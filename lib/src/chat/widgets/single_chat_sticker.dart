import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 다목적 사용자 정보 표시 스티커
///
/// 왼쪽에 사용자 프로필 사진, 오른쪽에 사용자 이름, 가입 날짜, 성별, 나일 등을 옵션으로 표시한다.
/// 사용자 목록/검색, 채팅 목록에 1:1 친구 목록 등에서 사용 될 수 있다.
///
/// 주의, [onTap] 으로 전달(리턴)되는 DocumentSnapshot 은 채팅방의 DocumentSnapshot 가 아니라,
/// 개인 사용자의 User Public Data Document Snapshot 이다.
///
class SingleChatSticker extends StatelessWidget {
  const SingleChatSticker({
    super.key,
    required this.userDocumentReference,
    required this.onTap,
  });

  /// 사용자의 DocumentReference
  final DocumentReference userDocumentReference;

  final void Function(DocumentSnapshot doc) onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      /// 사용자 공개 문서
      stream: UserService.instance.publicDataCol
          .doc(userDocumentReference.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        /// 사용자 공개 문서가 없으면, 빈 위젯 리턴.
        if (snapshot.data!.data() == null) {
          return const SizedBox.shrink();
        }

        final user = UsersPublicDataRecord.getDocumentFromData(
            snapshot.data!.data() as Map<String, dynamic>,
            snapshot.data!.reference);

        return GestureDetector(
          /// 사용자 공개 문서 snapshot
          onTap: () => onTap(snapshot.data!),
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
                    : user.displayName!),
                Text('Chat room: ${userDocumentReference.id}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
