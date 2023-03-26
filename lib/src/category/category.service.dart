import 'package:fireflow/fireflow.dart';

class CategoryService {
  static CategoryService get instance => _instance ??= CategoryService();
  static CategoryService? _instance;

  FirebaseFirestore get db => firestore ?? AppService.instance.db;
  CollectionReference get col => db.collection('categories');
  DocumentReference doc(String category) => col.doc(category);

  /// For testing purpose.
  FirebaseFirestore? firestore;

  /// [categoryId] is the category ID like 'qna', 'news', 'etc'. It's not
  /// the doucment ID.
  Future<DocumentReference> create({
    required String categoryId,
    String? title,
  }) async {
    if (await exists(categoryId)) {
      throw Exception('Category with the [$categoryId] already exists');
    }
    await doc(categoryId).set({
      'categoryId': categoryId,
      if (title != null) 'title': title,
    });

    return doc(categoryId);
  }

  Future<bool> exists(
    String categoryId,
  ) async {
    return (await doc(categoryId).get()).exists;
  }

  Future<CategoriesRecord> get({
    required DocumentReference categoryDocumentReference,
  }) async {
    return CategoriesRecord.getDocumentOnce(
      categoryDocumentReference,
    );
  }
}
