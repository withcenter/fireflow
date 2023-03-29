import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class ReportList extends StatelessWidget {
  const ReportList({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      itemBuilder: (context, documentSnapshots, index) {
        final report = ReportModel.fromSnapshot(documentSnapshots[index]);
        return ListTile(
          title: Text(report.target.path),
          subtitle: Text(report.reason),
          onTap: () {
            //
          },
        );
      },
      query:
          ReportService.instance.col.where('reporter', isEqualTo: my.reference),
      isLive: true,
      onEmpty: const Center(child: Text('No reports')),
    );
  }
}
