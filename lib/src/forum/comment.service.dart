import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
// import 'package:collection/collection.dart';

class CommentService {
  static CommentService get instance => _instance ??= CommentService();
  static CommentService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('comments');

  DocumentReference doc(String category) => col.doc(category);

  /// Returns the snapshot of comemnt list of the post.
  ///
  /// Use this to list the comments on post view screen.
  Stream<QuerySnapshot<Object?>> children(String postId) {
    return CommentService.instance.col
        .where('postDocumentReference',
            isEqualTo: PostService.instance.doc(postId))
        .orderBy('order', descending: false)
        .snapshots();
  }

  Future<CommentModel> get(String id) async {
    final snapshot = await CommentService.instance.doc(id).get();
    return CommentModel.fromSnapshot(snapshot);
  }

  /// 코멘트 생성
  ///
  /// [parentOrder] 는 부모 코멘트의 order. 부모 코멘트가 없으면 null.
  /// [parentDepth] 는 부모 코멘트의 depth. 부모 코멘트가 없으면 null.
  /// [postNoOfComment] 는 글의 noOfComment 값.
  /// [categoryId] 는 필수 값이며, 코멘트의 카테고리가 부모의 카테고리를 따라 간다.
  ///
  ///
  /// Finishes the comment creation.
  ///
  /// To create a comment, add a document under the comment collection in Firestore. Then call `afterCreate`.
  /// The `depth` field must be set to 1.
  /// ```dart
  /// ElevatedButton(
  ///     onPressed: () async {
  ///     final ref = await CommentService.instance.col.add({
  ///         'postDocumentReference': PostService.instance.doc(widget.postId),
  ///         'userDocumentReference': UserService.instance.ref,
  ///         'content': comment.text,
  ///         'createdAt': FieldValue.serverTimestamp(),
  ///         'order': commentOrder(null, null, post.noOfComments),
  ///         'depth': 1,
  ///     });
  ///     await CommentService.instance.afterCreate(commentDocumentReference: ref);
  ///     },
  ///     child: const Text('Submit'),
  /// ),
  /// ```
  ///
  create({
    required DocumentReference postDocumentReference,
    DocumentReference? parentCommentDocumentReference,
    required DocumentReference userDocumentReference,
    required String categoryId,
    String? content,
    String? parentOrder,
    int? parentDepth,
    int? postNoOfComment,
  }) async {
    final newCommentReference = col.doc();

    final createData = CommentModel.toCreate(
      reference: newCommentReference,
      postDocumentReference: postDocumentReference,
      // parentCommentDocumentReference: parentCommentDocumentReference,
      userDocumentReference: userDocumentReference,
      content: content,
      parentOrder: parentOrder,
      parentDepth: parentDepth,
      postNoOfComment: postNoOfComment,
    );

    await newCommentReference.set(createData);

    final comment =
        CommentModel.fromJson(createData, reference: newCommentReference);

    // 카테고리 reference
    final categoryDocumentReference = CategoryService.instance.doc(categoryId);

    // 푸시 알림 전송
    // send message to the post's owner and comment's owners of the hierachical ancestors
    final ancestorReferences = await _getAncestorsUid(comment);
    final userRefs =
        await UserService.instance.newCommentSubscribers(ancestorReferences);

    /// send push notifications to the subscribers of the category
    ///
    /// send message to the post's owner and comment's owners of the hierachical ancestors
    final snapshot = await UserSettingService.instance.col
        .where('commentSubscriptions', arrayContains: categoryDocumentReference)
        .get();
    if (snapshot.size > 0) {
      for (final doc in snapshot.docs) {
        final setting = UserSettingModel.fromSnapshot(doc);
        userRefs.add(setting.userDocumentReference);
      }
    }

    List<Future> futures = [];

    // send push notification
    futures.add(
      MessagingService.instance.send(
        notificationTitle: '${my.displayName} says ...',
        notificationText: comment.safeContent,
        notificationSound: 'default',
        notificationImageUrl:
            comment.files.isNotEmpty ? comment.files.first : null,
        userRefs: userRefs,
        initialPageName: 'PostView',
        parameterData: {'postDocumentReference': comment.postDocumentReference},
      ),
    );

    // increase on of comments in category docuemnt, user doucment, post document

    // update the user's post count
    futures.add(comment.postDocumentReference
        .update({'noOfComments': FieldValue.increment(1)}));
    futures.add(categoryDocumentReference
        .update({'noOfComments': FieldValue.increment(1)}));

    /// Update the no of comments on system settings
    ///
    /// Note that, user cannot update system settings.
    // futures.add(SystemSettingService.instance.increaseNoOfComments());

    // update the user's post count
    futures.add(
      UserService.instance.update(
        noOfComments: FieldValue.increment(1),
      ),
    );

    if (SupabaseService.instance.storeComments) {
      futures.add(
        supabase.comments.insert(
          {
            'comment_id': comment.id,
            'category_id': categoryId,
            'post_id': comment.postDocumentReference.id,
            'uid': comment.userDocumentReference.id,
            'created_at': comment.createdAt.toDate().toIso8601String(),
            'content': comment.content,
          },
        ),
      );
    }
    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.insert(
          {
            'id': comment.id,
            'post_id': comment.postDocumentReference.id,
            'comment_id': comment.id,
            'category_id': categoryId,
            'uid': comment.userDocumentReference.id,
            'created_at': comment.createdAt.toDate().toIso8601String(),
            'content': comment.content,
          },
        ),
      );
    }

    await Future.wait(futures);
  }

  update({
    required DocumentReference commentDocumentReference,
    String? content,
  }) async {
    // 업데이트
    await commentDocumentReference.update({
      if (content != null) 'content': content,
    });

    // 읽기
    final comment =
        CommentModel.fromSnapshot(await commentDocumentReference.get());

    //
    List<Future> futures = [];
    // update the user's post count
    futures.add(
      commentDocumentReference.update(
        {
          'updatedAt': FieldValue.serverTimestamp(),
        },
      ),
    );

    if (SupabaseService.instance.storeComments) {
      futures.add(
        supabase.comments.upsert(
          {
            'comment_id': commentDocumentReference.id,
            'post_id': comment.postDocumentReference.id,
            'category': comment.category,
            'uid': comment.userDocumentReference.id,
            'created_at': comment.createdAt.toDate().toIso8601String(),
            'content': comment.content,
          },
          onConflict: 'comment_id',
        ),
      );
    }

    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.upsert(
          {
            'id': commentDocumentReference.id,
            'post_id': comment.postDocumentReference.id,
            'comment_id': commentDocumentReference.id,
            'category': comment.category,
            'uid': comment.userDocumentReference.id,
            'created_at': comment.createdAt.toDate().toIso8601String(),
            'content': comment.content,
          },
          onConflict: 'id',
        ),
      );
    }

    await Future.wait(futures);
  }

  delete({required DocumentReference commentDocumentReference}) async {
    await commentDocumentReference.update({'deleted': true});

    final comment =
        CommentModel.fromSnapshot(await commentDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(comment.category);

    List<Future> futures = [];
    // update the user's post count
    futures.add(
      comment.postDocumentReference.update(
        {
          'noOfComments': FieldValue.increment(-1),
        },
      ),
    );

    futures.add(
      categoryDoc.update(
        {
          'noOfComments': FieldValue.increment(-1),
        },
      ),
    );

    if (SupabaseService.instance.storeComments) {
      futures.add(
        supabase.comments.delete().eq('comment_id', comment.id),
      );
    }
    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.delete().eq('id', comment.id),
      );
    }

    await Future.wait(futures);
  }

  /// Returns the list of user document references of the comment's ancestors
  /// including the user reference of the post author.
  ///
  /// The list of return contains unique user document references.
  Future<List<DocumentReference>> _getAncestorsUid(CommentModel comment) async {
    final List<DocumentReference> ancestors = [];
    ancestors.add(comment.userDocumentReference);
    final post =
        await PostService.instance.get(comment.postDocumentReference.id);
    ancestors.add(post.userDocumentReference);

    /// Get ancestors comments and post.
    ///
    /// Cannot use `Future.all()` here.
    while (comment.parentCommentDocumentReference != null) {
      final parent = await CommentService.instance
          .get(comment.parentCommentDocumentReference!.id);
      ancestors.add(parent.userDocumentReference);
      comment = parent;
    }

    return ancestors.toSet().toList();
  }
}
