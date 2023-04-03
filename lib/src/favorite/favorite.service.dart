import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

enum FavoriteType {
  /// 글
  posts,

  comments,

  /// 유저
  users,
}

/// 즐겨찾기 서비스
///
///
class FavoriteService {
  /// Singleton
  static FavoriteService? _instance;
  static FavoriteService get instance => _instance ??= FavoriteService._();
  FavoriteService._();

  CollectionReference get col =>
      FirebaseFirestore.instance.collection('favorites');

  /// 나의 전체 즐겨찾기 쿼리
  Query get myFavorites =>
      col.where('userDocumentReference', isEqualTo: my.reference);

  /// 특정 즐겨찾기 1개 쿼리
  Query query(DocumentReference targetDocumentReference) => col
      .where('userDocumentReference', isEqualTo: my.reference)
      .where('targetDocumentReference', isEqualTo: targetDocumentReference);

  /// 특정 즐겨찾기 1개 가져오기
  Future<FavoriteModel?> get(DocumentReference targetDocumentReference) async {
    final querySnapshot = await query(targetDocumentReference).get();
    if (querySnapshot.size == 0) return null;

    return FavoriteModel.fromSnapshot(querySnapshot.docs.first);
  }

  /// 즐겨찾기 추가 또는 삭제
  ///
  /// If the favorite does not exist, it will be created and true will be returned.
  /// If the favorite exists, it will be deleted and false will be returned.
  Future<bool> set({
    required DocumentReference targetDocumentReference,
  }) async {
    final type = targetDocumentReference.path.split('/').first;
    final favorite = await get(targetDocumentReference);

    if (favorite == null) {
      await col.add(createFavorite(
          type: type, targetDocumentReference: targetDocumentReference));
      return true;
    } else {
      await favorite.reference.delete();
      return false;
    }
  }
}
