import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  static CategoryService get instance => _instance ??= CategoryService();
  static CategoryService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get col => db.collection('categories');
  DocumentReference doc(String category) => col.doc(category);

  Future<DocumentReference> create({
    required String category,
    String? title,
  }) async {
    await doc(category).set({
      'category': category,
      if (title != null) 'title': title,
    });

    return doc(category);
  }
}
