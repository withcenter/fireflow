import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 채팅방에 읽지 않은 새로운 채팅이 있으면 빨간점 표시.
class ChatRoomReadBadge extends StatelessWidget {
  const ChatRoomReadBadge({
    super.key,
    required this.room,
    this.margin,
  });

  final ChatRoomModel room;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return room.isMember == false || room.isRead
        ? const SizedBox.shrink()
        : Container(
            width: 5,
            height: 5,
            margin: margin,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
          );
  }
}
