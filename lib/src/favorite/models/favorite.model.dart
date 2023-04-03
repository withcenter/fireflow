import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// 즐겨찾기 모델
///
///
class FavoriteModel {
  final DocumentReference reference;
  final DocumentReference userDocumentReference;
  final String type;
  final DocumentReference targetDocumentReference;
  final DateTime? createdAt;

  FavoriteModel({
    required this.reference,
    required this.userDocumentReference,
    required this.type,
    required this.targetDocumentReference,
    required this.createdAt,
  });

  factory FavoriteModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FavoriteModel(
      reference: snapshot.reference,
      userDocumentReference: data['userDocumentReference'] as DocumentReference,
      type: data['type'] as String,
      targetDocumentReference:
          data['targetDocumentReference'] as DocumentReference,
      createdAt: data['createdAt'] == null
          ? null
          : (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userDocumentReference': userDocumentReference,
      'type': type,
      'targetDocumentReference': targetDocumentReference,
      'createdAt': createdAt,
    };
  }
}

/// Favorite 문서를 생성하기 위한 함수
Map<String, dynamic> createFavorite({
  required String type,
  required DocumentReference targetDocumentReference,
}) {
  return {
    'userDocumentReference': my.reference,
    'type': type,
    'targetDocumentReference': targetDocumentReference,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
