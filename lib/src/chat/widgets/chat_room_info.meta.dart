import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 채팅방 목록에서, 날짜와 읽지 않은 메시지 배지를 표시한다.
class ChatRoomInfoMeta extends StatelessWidget {
  const ChatRoomInfoMeta({
    super.key,
    required this.room,
  });

  final ChatRoomModel room;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ShortDateTime(
        dateTime: room.lastMessageSentAt,
        style: const TextStyle(fontSize: 12),
      ),
      ChatRoomReadBadge(room: room, margin: const EdgeInsets.only(top: 6)),
    ]);
  }
}
