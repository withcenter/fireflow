import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

class ReportService {
  static ReportService? _instance;
  static ReportService get instance => _instance ??= ReportService._();

  ReportService._();

  final col = FirebaseFirestore.instance.collection('reports');

  String targetId(DocumentReference targetDocumentReference) {
    return '${targetDocumentReference.path.replaceAll('/', '-')}-${my.uid}';
  }

  /// 신고하기
  Future<ReportModel> create({
    required DocumentReference targetDocumentReference,
    required DocumentReference reportee,
    required String reason,
  }) async {
    final data = {
      'reporter': my.reference,
      'reportee': reportee,
      'targetDocumentReference': targetDocumentReference,
      'reason': reason,
      'reportedAt': FieldValue.serverTimestamp(),
    };

    /// 고유한 문서 ID. 참고, readme.
    final doc = col.doc(targetId(targetDocumentReference));

    await doc.set(data, SetOptions(merge: true));
    final snapshot = await doc.get();
    return ReportModel.fromSnapshot(snapshot);
  }

  /// 신고한 글 읽어 ReportModel 로 리턴
  ///
  /// 처음 신고하는 글에는 이전에 리포팅된 문서가 없으므로, NULL 을 리턴한다.
  Future<ReportModel?> get(
      {required DocumentReference targetDocumentReference}) async {
    final querySnapshot = await col
        .where('reporter', isEqualTo: my.reference)
        .where('targetDocumentReference', isEqualTo: targetDocumentReference)
        .get();
    if (querySnapshot.size == 0) {
      return null;
    }

    final snapshot = querySnapshot.docs.first;
    return ReportModel.fromSnapshot(snapshot);
  }
}
