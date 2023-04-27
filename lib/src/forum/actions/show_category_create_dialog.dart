import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 카테고리 생성에 필요한 전체 기능을 가진 화면을 보여준다.
///
///
void showCategoryCreateDialog(
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
          title: const Text('Post Create'),
        ),
        body: SingleChildScrollView(
          child: CategoryCreate(
            onCreated: (categoryDocumentReference) {
              Navigator.of(context).pop(true);
              if (onCreated != null) {
                onCreated(categoryDocumentReference);
              }
            },
          ),
        ),
      );
    },
  );
}
