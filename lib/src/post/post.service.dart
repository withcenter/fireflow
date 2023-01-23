import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:collection/collection.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('posts');
  DocumentReference doc(String category) => col.doc(category);

  UserPublicDataModel get my => UserService.instance.my;

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
    if (snapshot.size > 0) {
      final List<DocumentReference> userRefs = [];
      for (final doc in snapshot.docs) {
        final setting = UserSettingModel.fromSnapshot(doc);
        userRefs.add(setting.userDocumentReference);
      }

      MessagingService.instance.send(
        notificationTitle: post.safeTitle,
        notificationText: post.safeContent,
        notificationSound: 'default',
        notificationImageUrl: post.files.firstOrNull,
        userRefs: userRefs,
        initialPageName: 'PostView',
        parameterData: {'postDocumentReference': post.ref},
      );
    }

    await postDocumentReference.update({
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
      'wasPremiumUser': UserService.instance.my.isPremiumUser,
      'emphasizePremiumUserPost': category.emphasizePremiumUserPost
    });

    // update the user's post count
    await UserService.instance.publicRef.update(
      {
        'noOfPosts': FieldValue.increment(1),
      },
    );

    //
    await categoryDoc.update(
      {
        'noOfPosts': FieldValue.increment(1),
      },
    );

    if (SupabaseService.instance.backupPosts) {
      await supabase.posts.insert(
        {
          'postId': postDocumentReference.id,
          'category': post.category,
          'uid': my.uid,
          'created_at': post.createdAt.toDate().toIso8601String(),
          'updated_at': post.updatedAt.toDate().toIso8601String(),
          'title': post.title,
          'content': post.content,
        },
      );
    }
  }

  Future afterUpdate({
    required DocumentReference postDocumentReference,
  }) async {
    PostModel post = PostModel.fromSnapshot(await postDocumentReference.get());

    /// Update `updatedAt`
    await postDocumentReference.update({
      'updatedAt': FieldValue.serverTimestamp(),
      'hasPhoto': post.files.isNotEmpty,
    });

    /// Read the `updatdAt`
    post = PostModel.fromSnapshot(await postDocumentReference.get());

    if (SupabaseService.instance.backupPosts) {
      await supabase.posts.upsert({
        'postId': postDocumentReference.id,
        'category': post.category,
        'updated_at': post.updatedAt.toDate().toIso8601String(),
        'title': post.title,
        'content': post.content,
      }, onConflict: 'postId');
    }
  }

  /// post create method
  Future afterDelete({
    required DocumentReference postDocumentReference,
  }) async {
    // get the post's data from the database
    final post = PostModel.fromSnapshot(await postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    final category = CategoryModel.fromSnapshot(await categoryDoc.get());

    // update the user's post count
    await UserService.instance.publicRef.update(
      {
        'noOfPosts': FieldValue.increment(-1),
      },
    );

    //
    await categoryDoc.update(
      {
        'noOfPosts': FieldValue.increment(-1),
      },
    );

    if (SupabaseService.instance.backupPosts) {
      await supabase.posts.delete().eq('postId', post.id);
    }
  }
}
