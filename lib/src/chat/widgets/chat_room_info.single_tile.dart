import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 1:1 채팅방 정보 - 목록에 표시할 때 사용하는 Tile
///
/// 왼쪽에 사용자 프로필 사진, 오른쪽에 사용자 이름, 가입 날짜, 성별, 나일 등을 옵션으로 표시한다.
/// 사용자 목록/검색, 채팅 목록에 1:1 친구 목록 등에서 사용 될 수 있다.
///
/// 주의, [onTap] 으로 전달(리턴)되는 것은 사용자의 UserModel 이다.
///
class ChatRoomInfoSingleTile extends StatelessWidget {
  const ChatRoomInfoSingleTile({
    super.key,
    required this.room,
    required this.onTap,
  });

  /// 사용자의 DocumentReference
  final ChatRoomModel room;

  final void Function(UserModel doc) onTap;

  @override
  Widget build(BuildContext context) {
    final ref = ChatService.instance
        .getOtherUserDocumentReferenceFromChatRoomReference(room.reference);

    if (ref.id == '6BZK9HOlCfghBgrBx5D9') {
      return const SizedBox.shrink();
    }
    return UserDoc(
      /// 사용자 공개 문서
      reference: ref,
      builder: (user) {
        return GestureDetector(
          /// 사용자 공개 문서 snapshot
          onTap: () => onTap(user),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                UserAvatar(user: user),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.displayName == ''
                          ? 'No display name'
                          : user.displayName),
                      Text(
                        'User: ${room.lastMessage}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ChatRoomInfoMeta(room: room),
              ],
            ),
          ),
        );
      },
    );
  }
}
