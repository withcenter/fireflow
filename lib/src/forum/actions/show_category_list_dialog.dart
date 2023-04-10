import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 카테고리 목록에 필요한 전체 기능을 가진 화면을 보여준다.
///
///
void showCategoryListDialog(
    {required BuildContext context,
    void Function(DocumentReference)? onCreated}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, a, b) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Category List'),
        ),
        body: const CategoryList(),
      );
    },
  );
}
