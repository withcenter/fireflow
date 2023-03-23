import 'package:fireflow/fireflow.dart';

class CategoryService {
  static CategoryService get instance => _instance ??= CategoryService();
  static CategoryService? _instance;

  FirebaseFirestore get db => firestore ?? AppService.instance.db;
  CollectionReference get col => db.collection('categories');
  DocumentReference doc(String category) => col.doc(category);

  /// For testing purpose.
  FirebaseFirestore? firestore;

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
