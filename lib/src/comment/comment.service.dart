import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  static CommentService get instance => _instance ??= CommentService();
  static CommentService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('comments');
  DocumentReference doc(String category) => col.doc(category);
}
