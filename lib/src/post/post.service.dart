import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('posts');
  DocumentReference doc(String category) => col.doc(category);

  UserPublicDataModel get my => UserService.instance.my;

  /// post create method
  Future afterCreate({
    required DocumentReference postDocumentReference,
  }) async {
    // get the post's data from the database
    final post = PostModel.fromSnapshot(await postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    final category = CategoryModel.fromSnapshot(await categoryDoc.get());

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

    // TODO push notification to the category's followers

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

    if (AppService.instance.supabase) {
      await supabase.posts.insert(
        {
          'postId': postDocumentReference.id,
          'category': post.category,
          'uid': my.uid,
          'created_at': post.createdAt.toDate().toIso8601String(),
          'updated_at': post.updatedAt.toDate().toIso8601String(),
          'title': post.title,
          'content': post.content,
          'deleted': false,
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

    if (AppService.instance.supabase) {
      await supabase.posts.update(
        {
          'category': post.category,
          'updated_at': post.updatedAt.toDate().toIso8601String(),
          'title': post.title,
          'content': post.content,
          'deleted': false,
        },
      ).eq('postId', postDocumentReference.id);
    }
  }
}
