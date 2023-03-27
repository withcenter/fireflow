import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

class CategoryService {
  static CategoryService get instance => _instance ??= CategoryService();
  static CategoryService? _instance;

  FirebaseFirestore get db => firestore ?? AppService.instance.db;
  CollectionReference get col => db.collection('categories');
  DocumentReference doc(String category) => col.doc(category);

  /// For testing purpose.
  FirebaseFirestore? firestore;

  /// 카테고리 생성
  ///
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

  /// 카테고리 업데이트
  Future update({
    required DocumentReference categoryDocumentReference,
    String? title,
    int? waitMinutesForNextPost,
    int? waitMinutesForPremiumUserNextPost,
    bool? emphasizePremiumUserPost,
  }) async {
    return categoryDocumentReference.update(CategoryModel.toUpdate(
      title: title,
      waitMinutesForNextPost: waitMinutesForNextPost,
      waitMinutesForPremiumUserNextPost: waitMinutesForPremiumUserNextPost,
      emphasizePremiumUserPost: emphasizePremiumUserPost,
    ));
  }

  /// 카테고리 삭제
  ///
  /// 반드시 이 함수를 통해서 삭제해야 한다. 각종 초기화 작업이 필요하기 때문이다.
  Future delete({
    required DocumentReference categoryDocumentReference,
  }) {
    return categoryDocumentReference.delete();
  }

  /// 카테고리 존재 확인
  Future<bool> exists(
    String categoryId,
  ) async {
    return (await doc(categoryId).get()).exists;
  }

  /// 카테고리 가져오기
  Future<CategoryModel> get({
    required DocumentReference categoryDocumentReference,
  }) async {
    return CategoryModel.fromSnapshot(await categoryDocumentReference.get());
  }
}
