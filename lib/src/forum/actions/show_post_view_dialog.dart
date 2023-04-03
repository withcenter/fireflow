import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 글 읽기에 필요한 전체 기능을 가진 화면을 보여준다.
/// 글 수정, 삭제 부터 시작해서 모든 기능의 버튼을 다 포함한다.
void showPostViewDialog(BuildContext context, PostModel post) {
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
            child: PostView(
              post: post,
              onDelete: (post) {
                Navigator.of(context).pop();
              },
              onEdit: (post) => showPostEditDialog(context, post),
            ),
          ),
        ),
      );
    },
  );
}
