import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/user/widgets/other_doc.dart';
import 'package:flutter/material.dart';

/// UserSticker 를 실시간 업데이트 해서 보여준다.
///
///
class UserStickerStream extends StatelessWidget {
  const UserStickerStream({
    super.key,
    required this.otherUserDocumentReference,
    required this.onTap,
  });

  /// 사용자의 DocumentReference
  final DocumentReference otherUserDocumentReference;

  final void Function(UserModel doc) onTap;

  @override
  Widget build(BuildContext context) {
    return OtherDoc(
      otherUserDocumentReference: otherUserDocumentReference,
      builder: (user) => UserSticker(
        user: user,
        onTap: onTap,
      ),
    );
  }
}
