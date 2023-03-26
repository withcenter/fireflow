import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/user/widgets/other_doc.dart';
import 'package:flutter/material.dart';

/// 다목적 사용자 정보 표시 스티커
///
/// 왼쪽에 사용자 프로필 사진, 오른쪽에 사용자 이름, 가입 날짜, 성별, 나일 등을 옵션으로 표시한다.
/// 사용자 목록/검색, 채팅 목록에 1:1 친구 목록 등에서 사용 될 수 있다.
///
/// 주의, [onTap] 으로 전달(리턴)되는 것은 사용자의 UserModel 이다.
///
class SingleChatSticker extends StatelessWidget {
  const SingleChatSticker({
    super.key,
    required this.userDocumentReference,
    required this.onTap,
  });

  /// 사용자의 DocumentReference
  final DocumentReference userDocumentReference;

  final void Function(UserModel doc) onTap;

  @override
  Widget build(BuildContext context) {
    return OtherDoc(
      /// 사용자 공개 문서
      otherUserDocumentReference: userDocumentReference,
      builder: (user) {
        return GestureDetector(
          /// 사용자 공개 문서 snapshot
          onTap: () => onTap(user),
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName == ''
                    ? 'No display name'
                    : user.displayName),
                Text('Chat room: ${userDocumentReference.id}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
