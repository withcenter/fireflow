import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// UserSticker 를 실시간 업데이트 해서 보여준다.
///
///
class UserStickerStream extends StatelessWidget {
  const UserStickerStream({
    super.key,
    required this.reference,
    required this.onTap,
    this.title,
    this.displayName = true,
    this.uid = false,
  });

  /// 사용자의 DocumentReference
  final DocumentReference reference;

  final void Function(UserModel doc) onTap;

  final Widget? title;

  final bool displayName;
  final bool uid;

  @override
  Widget build(BuildContext context) {
    return UserDoc(
      reference: reference,
      builder: (user) => UserSticker(
        user: user,
        onTap: onTap,
        title: title,
        displayName: displayName,
        uid: uid,
      ),
    );
  }
}
