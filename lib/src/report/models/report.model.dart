import 'package:cloud_firestore/cloud_firestore.dart';

/// 신고 모델
///
/// target 의 경로 중, collection 값을 보고, 글/코멘트/사용자/채팅 등을 구분한다.
///
class ReportModel {
  final DocumentReference reference;
  final DocumentReference reporter;
  final DocumentReference reportee;
  final DocumentReference targetDocumentReference;
  final String reason;
  final DateTime reportedAt;
  final String collection;

  ReportModel({
    required this.reference,
    required this.reporter,
    required this.reportee,
    required this.targetDocumentReference,
    required this.reason,
    required this.reportedAt,
    required this.collection,
  });

  factory ReportModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final targetDocumentReference =
        data['targetDocumentReference'] as DocumentReference;
    return ReportModel(
      reference: snapshot.reference,
      reporter: data['reporter'] as DocumentReference,
      reportee: data['reportee'] as DocumentReference,
      targetDocumentReference: targetDocumentReference,
      reason: data['reason'] as String,
      reportedAt: (data['reportedAt'] as Timestamp).toDate(),
      collection: targetDocumentReference.path.split('/')[0],
    );
  }
}
