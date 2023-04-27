import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/favorite/widgets/favorite.list.post.dart';
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

        /// 글 즐겨찾기
        if (report.collection == Collections.posts.name) {
          return FavoritePostTile(
            postDocumentReference: report.targetDocumentReference,
          );

          /// 코멘트 즐겨찾기
        } else if (report.collection == Collections.comments.name) {
          return Row(
            children: [
              Text(
                report.targetDocumentReference.path,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(width: 10),
              Text(report.reportedAt.toString()),
            ],
          );

          /// 사용자 즐겨찾기
        } else if (report.collection == Collections.users.name) {
          return UserSticker(
            reference: report.targetDocumentReference,
            onTap: (user) => showUserPublicProfileDialog(context, user),

            // Navigator.of(context).pushNamed(
            //   '/user/${user.reference.id}',
            // ),
            trailing: const Icon(Icons.chevron_right),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      query:
          ReportService.instance.col.where('reporter', isEqualTo: my.reference),
      isLive: true,
      onEmpty: const Center(child: Text('No reports')),
    );
  }
}
