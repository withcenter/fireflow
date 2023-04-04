import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 회원 공개 프로필 보여주는 다이얼로그
///
void showUserPublicProfileDialog(BuildContext context, UserModel user) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PublicProfile(
              user: user,
            ),
          ),
        ),
      );
    },
  );
}
