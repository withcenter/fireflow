import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

void showPostEditDialog(BuildContext context, PostModel post) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PostEdit(
              postDocumentReference: post.reference,
              onEdit: (post) {
                Navigator.of(context).pop();
              },
              onFileUpload: (post) {
                dog(post.toString());
              },
            ),
          ),
        ),
      );
    },
  );
}
