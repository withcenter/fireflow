import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// TODO 채팅방 정보 목록을 내부적으로 캐시를 했다가 빠르게 보여주고, 업데이트된 내용을 rebuild 해서 보여준다.
///
/// 1:1 채팅방이든 그룹 채팅방이든, 공통으로 채팅방의 정보(마지막 채팅, 시간, 읽음 표시 등)를 보여준다.
/// 또한 채팅방의 정보 [chatRoom] 은 상위 부모 위젯에서 rebuild 하므로, 특별히 여기서 [chatRoom] 을 listen 할 필요 없다.
class ChatRoomInfoTile extends StatelessWidget {
  const ChatRoomInfoTile(
      {super.key, required this.chatRoom, required this.onTap});

  final ChatRoomModel chatRoom;
  final void Function(ChatRoomModel chatRoom) onTap;

  @override
  Widget build(BuildContext context) {
    return chatRoom.isGroupChat
        ? ChatRoomInfoGroupTile(
            room: chatRoom,
            onTap: (room) => onTap(room),
          )
        : ChatRoomInfoSingleTile(
            room: chatRoom,
            onTap: (user) => onTap(chatRoom),
          );
  }
}
