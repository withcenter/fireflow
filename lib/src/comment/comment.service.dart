import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/comment_order.dart';

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
        .where('postDocumentReference', isEqualTo: PostService.instance.doc(postId))
        .orderBy('order', descending: false)
        .snapshots();
  }

  afterCreate({required DocumentReference commentDocumentReference}) async {
    final comment = CommentModel.fromSnapshot(await commentDocumentReference.get());
    final post = PostModel.fromSnapshot(await comment.postDocumentReference.get());

    // CommentModel? parent;
    // if (comment.parentCommentDocumentReference != null) {
    //   parent = CommentModel.fromSnapshot(await comment.parentCommentDocumentReference!.get());
    // }

    final categoryDoc = CategoryService.instance.doc(post.category);
    // update comment
    // add category of the post, update `order` field.
    await commentDocumentReference.update({
      'category': post.category,
    });

    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    // increase on of comments in category docuemnt, user doucment, post document

    // update the user's post count
    await post.ref.update(
      {
        'noOfComments': FieldValue.increment(1),
      },
    );

    await categoryDoc.update(
      {
        'noOfComments': FieldValue.increment(1),
      },
    );
    // update the user's post count
    await UserService.instance.publicRef.update(
      {
        'noOfComments': FieldValue.increment(1),
      },
    );

    if (AppService.instance.supabase) {
      await supabase.comments.insert(
        {
          'commentId': commentDocumentReference.id,
          'category': post.category,
          'postId': post.id,
          'uid': post.userDocumentReference.id,
          'created_at': comment.createdAt.toDate().toIso8601String(),
          'updated_at': comment.updatedAt.toDate().toIso8601String(),
          'content': comment.content,
        },
      );
    }
  }

  afterUpdate({required DocumentReference commentDocumentReference}) async {
    // send push notification
    // send message to the post's owner and comment's owners of the hierachical ancestors

    final comment = CommentModel.fromSnapshot(await commentDocumentReference.get());

    // update the user's post count
    await commentDocumentReference.update(
      {
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );

    if (AppService.instance.supabase) {
      await supabase.comments.update(
        {
          'updated_at': comment.updatedAt.toDate().toIso8601String(),
          'content': comment.content,
        },
      ).eq('commentId', comment.id);
    }
  }
}
