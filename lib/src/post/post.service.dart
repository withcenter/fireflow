import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
// import 'package:collection/collection.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('posts');
  DocumentReference doc(String category) => col.doc(category);

  UserPublicDataModel get pub => UserService.instance.pub;

  /// Get the post
  Future<PostModel> get(String id) async {
    final snapshot = await PostService.instance.doc(id).get();
    return PostModel.fromSnapshot(snapshot);
  }

  /// post create method
  Future afterCreate({
    required DocumentReference postDocumentReference,
  }) async {
    // get the post's data from the database
    final post = PostModel.fromSnapshot(await postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    final category = CategoryModel.fromSnapshot(await categoryDoc.get());

    /// send push notifications to the subscribers of the category
    final snapshot = await UserSettingService.instance.col
        .where('postSubscriptions', arrayContains: category.ref)
        .get();

    List<Future> futures = [];

    /// Send push notifications to the subscribers of the category
    if (snapshot.size > 0) {
      final List<DocumentReference> userRefs = [];
      for (final doc in snapshot.docs) {
        final setting = UserSettingModel.fromSnapshot(doc);
        userRefs.add(setting.userDocumentReference);
      }

      futures.add(
        MessagingService.instance.send(
          notificationTitle: post.safeTitle,
          notificationText: post.safeContent,
          notificationSound: 'default',
          notificationImageUrl: post.files.isNotEmpty ? post.files.first : null,
          userRefs: userRefs,
          initialPageName: 'PostView',
          parameterData: {'postDocumentReference': post.ref},
        ),
      );
    }

    // update the post
    futures.add(
      postDocumentReference.update({
        'postId': postDocumentReference.id,
        'userDocumentReference': UserService.instance.ref,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        if (post.files.isEmpty) 'files': [],
        'hasPhoto': post.files.isNotEmpty,
        'noOfComments': 0,
        'hasComment': false,
        'deleted': false,
        'likes': [],
        'noOfLikes': 0,
        'hasLike': false,
        'wasPremiumUser': UserService.instance.pub.isPremiumUser,
        'emphasizePremiumUserPost': category.emphasizePremiumUserPost
      }),
    );

    // update the category's post count
    futures.add(category.increaseNoOfPosts());

    /// Feed
    ///
    /// Update the user's post count together with feed.
    futures.add(
      UserService.instance.publicRef.update(
        {
          'lastPost': UserService.instance.feed(post).toJson(),
          'recentPosts': UserService.instance
              .recentPosts(post)
              .map((e) => e.toJson())
              .toList(),
          'noOfPosts': FieldValue.increment(1),
          'lastPostCreatedAt': FieldValue.serverTimestamp(),
        },
      ),
    );

    /// Update the no of posts on system settings
    ///
    /// Note that, user cannot update system settings.
    /// futures.add(SystemSettingService.instance.increaseNoOfPosts());

    // backup the post to supabase
    if (SupabaseService.instance.storePosts) {
      futures.add(
        supabase.posts.insert(
          {
            'post_id': postDocumentReference.id,
            'category': post.category,
            'uid': pub.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
        ),
      );
    }

    // backup the post to supabase
    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.insert(
          {
            'id': postDocumentReference.id,
            'post_id': postDocumentReference.id,
            'category': post.category,
            'uid': pub.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
        ),
      );
    }

    if (SupabaseService.instance.storeSearch) {
      futures.add(
        supabase.searchInsert(
          id: postDocumentReference.id,
          category: 'posts',
          text: "${post.title} ${post.content}",
        ),
      );
    }

    await Future.wait(futures);
  }

  Future afterUpdate({
    required DocumentReference postDocumentReference,
  }) async {
    PostModel post = PostModel.fromSnapshot(await postDocumentReference.get());

    List<Future> futures = [];

    /// Update `updatedAt`
    futures.add(
      postDocumentReference.update({
        'updatedAt': FieldValue.serverTimestamp(),
        'hasPhoto': post.files.isNotEmpty,
      }),
    );

    /// Note, the `updatedAt` field here is not the last time the post was updated.
    if (SupabaseService.instance.storePosts) {
      futures.add(
        supabase.posts.upsert(
          {
            'post_id': postDocumentReference.id,
            'category': post.category,
            'uid': pub.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
          onConflict: 'post_id',
        ),
      );
    }

    if (SupabaseService.instance.storePosts) {
      futures.add(
        supabase.postsAndComments.upsert(
          {
            'id': postDocumentReference.id,
            'post_id': postDocumentReference.id,
            'category': post.category,
            'uid': pub.uid,
            'created_at': post.createdAt.toDate().toIso8601String(),
            'title': post.title,
            'content': post.content,
          },
          onConflict: 'id',
        ),
      );
    }

    if (SupabaseService.instance.storeSearch) {
      futures.add(
        supabase.searchUpsert(
          id: postDocumentReference.id,
          category: 'posts',
          text: "${post.title} ${post.content}",
        ),
      );
    }

    await Future.wait(futures);
  }

  /// post create method
  Future afterDelete({
    required DocumentReference postDocumentReference,
  }) async {
    // get the post's data from the database
    final post = PostModel.fromSnapshot(await postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    // final category = CategoryModel.fromSnapshot(await categoryDoc.get());

    List<Future> futures = [];

    // update the user's post count
    futures.add(
      UserService.instance.publicRef.update(
        {
          'noOfPosts': FieldValue.increment(-1),
        },
      ),
    );

    //
    futures.add(
      categoryDoc.update(
        {
          'noOfPosts': FieldValue.increment(-1),
        },
      ),
    );

    if (SupabaseService.instance.storePosts) {
      futures.add(
        supabase.posts.delete().eq('post_id', post.id),
      );
    }
    if (SupabaseService.instance.storePostsAndComments) {
      futures.add(
        supabase.postsAndComments.delete().eq('id', post.id),
      );
    }

    if (SupabaseService.instance.storeSearch) {
      futures.add(
        supabase.searchDelete(
          postDocumentReference.id,
        ),
      );
    }

    await Future.wait(futures);
  }
}
