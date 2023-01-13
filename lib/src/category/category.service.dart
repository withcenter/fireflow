import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  static CategoryService get instance => _instance ??= CategoryService();
  static CategoryService? _instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  CollectionReference get categoriesCol => db.collection('categories');
  DocumentReference categoryDoc(String category) => categoriesCol.doc(category);

  Future<DocumentReference> create({
    required String category,
    String? title,
  }) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(category)
        .set({});

    await categoryDoc(category).set({
      if (title != null) 'title': title,
    });

    return categoryDoc(category);
  }
}
