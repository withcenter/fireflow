import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 글 생성에 필요한 전체 기능을 가진 화면을 보여준다.
void showPostCreateDialog({required BuildContext context, String? categoryId}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, a, b) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Post Create'),
        ),
        body: SingleChildScrollView(
          child: PostCreate(
            categoryId: categoryId,
            onCreated: (post) {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    },
  );
}
