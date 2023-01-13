import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/category/category.model.dart';
import 'package:fireflow/src/post/post.model.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('posts');
  DocumentReference doc(String category) => col.doc(category);

  /// post create method
  Future afterCreate({
    required DocumentReference postDocumentReference,
  }) async {
    // get the post's data from the database
    final post = PostModel.fromSnapshot(await postDocumentReference.get());
    final categoryDoc = CategoryService.instance.doc(post.category);
    final category = CategoryModel.fromSnapshot(await categoryDoc.get());

    final List<Future> futures = [];

    futures.add(postDocumentReference.update({
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
      'wasPremiumUser': UserService.instance.my?.isPremiumUser ?? false,
      'emphasizePremiumUserPost': category.emphasizePremiumUserPost
    }));

    // update the user's post count
    futures.add(UserService.instance.publicRef.update(
      {
        'noOfPosts': FieldValue.increment(1),
      },
    ));

    //
    futures.add(categoryDoc.update(
      {
        'noOfPosts': FieldValue.increment(1),
      },
    ));

    return;
  }
}
