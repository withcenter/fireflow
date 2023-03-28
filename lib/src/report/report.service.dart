import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

class ReportService {
  static ReportService? _instance;
  static ReportService get instance => _instance ??= ReportService._();

  ReportService._();

  final col = FirebaseFirestore.instance.collection('reports');

  String targetId(DocumentReference target) {
    return '${target.path.replaceAll('/', '-')}-${my.uid}';
  }

  /// 신고하기
  Future<ReportModel> create({
    required DocumentReference target,
    required DocumentReference reportee,
    required String reason,
  }) async {
    final data = {
      'reporter': my.reference,
      'reportee': reportee,
      'target': target,
      'reason': reason,
      'reportedAt': FieldValue.serverTimestamp(),
    };

    /// 고유한 문서 ID. 참고, readme.
    final doc = col.doc(targetId(target));

    await doc.set(data, SetOptions(merge: true));
    final snapshot = await doc.get();
    return ReportModel.fromSnapshot(snapshot);
  }

  /// 신고한 글 읽어 ReportModel 로 리턴
  Future<ReportModel> get({required DocumentReference target}) async {
    final snapshot = await col.doc(targetId(target)).get();
    return ReportModel.fromSnapshot(snapshot);
  }
}
