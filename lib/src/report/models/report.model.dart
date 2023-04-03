import 'package:cloud_firestore/cloud_firestore.dart';

/// 신고 모델
///
/// target 의 경로 중, collection 값을 보고, 글/코멘트/사용자/채팅 등을 구분한다.
///
class ReportModel {
  final DocumentReference reference;
  final DocumentReference reporter;
  final DocumentReference reportee;
  final DocumentReference target;
  final String reason;
  final DateTime reportedAt;
  final String collection;

  ReportModel({
    required this.reference,
    required this.reporter,
    required this.reportee,
    required this.target,
    required this.reason,
    required this.reportedAt,
    required this.collection,
  });

  factory ReportModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final target = data['target'] as DocumentReference;
    return ReportModel(
      reference: snapshot.reference,
      reporter: data['reporter'] as DocumentReference,
      reportee: data['reportee'] as DocumentReference,
      target: target,
      reason: data['reason'] as String,
      reportedAt: (data['reportedAt'] as Timestamp).toDate(),
      collection: target.path.split('/')[0],
    );
  }
}
