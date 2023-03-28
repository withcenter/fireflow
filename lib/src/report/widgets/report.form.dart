import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 신고 폼 위젯
///
/// 악성 글/코멘트/사용자/채팅메시지 등을 신고를 할 때 사용하는 범용 위젯.
///
/// [target] 은 신고할 대상 문서의 DocumentReference. 예) 글, 코멘트, 사용자, 채팅 메시지 문서의 DocumentReference
/// [reportee] 는 신고 되는 사람 또는 target 문서를 작성한 사람의 사용자 문서 DocumentReference
class ReportForm extends StatefulWidget {
  const ReportForm({
    super.key,
    required this.target,
    required this.reportee,
  });

  final DocumentReference target;
  final DocumentReference reportee;

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController reportController = TextEditingController();

  @override
  initState() {
    super.initState();
    ReportService.instance.get(target: widget.target).then((report) {
      setState(() {
        reportController.text = report.reason;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Report'),
          const SizedBox(height: 8),
          TextField(
            controller: reportController,
            decoration: const InputDecoration(
              hintText: 'You can report without reason',
              border: OutlineInputBorder(),
            ),
            minLines: 1,
            maxLines: 3,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () async {
                  ReportService.instance.create(
                    target: widget.target,
                    reportee: widget.reportee,
                    reason: reportController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Report without reason'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
