import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 그룹 채팅방 정보 표시 스티커
///
/// 왼쪽에 그룹 관련 사진, 오른쪽에 채팅방 정보(이름, 참여자 수, 최근 메시지, 시간 등)을 표시한다.
///
/// 채팅방 인원이 채팅을 하면, 정보가 실시간으로 변할 수 있는 데, 상위 부모에서 채팅방 문서를 listen 하고,
/// rebuild 하므로, 여기서는 그냥 [room] 을 받아서 표시만 해 준다.
///
///
class ChatRoomInfoGroupTile extends StatelessWidget {
  const ChatRoomInfoGroupTile({
    super.key,
    required this.room,
    required this.onTap,
  });

  final ChatRoomModel room;

  final void Function(ChatRoomModel doc) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(room),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GroupChatUserPhotos(
              room: room,
              border: 1,
              borderColor: outline,
              size: 42,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room.title == '' ? 'No title' : room.title),
                  Text(room.lastMessage.safe32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
