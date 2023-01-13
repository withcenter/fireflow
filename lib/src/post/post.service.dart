import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static PostService get instance => _instance ??= PostService();
  static PostService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get postsCol => db.collection('posts');
  DocumentReference postDoc(String category) => postsCol.doc(category);
}
