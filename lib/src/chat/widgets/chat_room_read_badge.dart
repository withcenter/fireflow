import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 채팅방에 읽지 않은 새로운 채팅이 있으면 빨간점 표시.
class ChatRoomReadBadge extends StatelessWidget {
  const ChatRoomReadBadge({
    super.key,
    required this.room,
    this.padding,
  });

  final ChatRoomModel room;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return room.isRead
        ? const SizedBox.shrink()
        : Container(
            width: 5,
            height: 5,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
          );
  }
}
