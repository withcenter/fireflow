import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatRoomMessage extends StatelessWidget {
  const ChatRoomMessage({
    super.key,
    required this.room,
    required this.type,
    required this.message,
  });
  final ChatRoomModel room;
  final String type;
  final ChatRoomMessageModel? message;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'my':
        return ChatRoomMessageMine(
          room: room,
          message: message!,
        );
      case 'other':
        return ChatRoomMessageOthers(
          message: message!,
        );
      case 'protocol':
        return ChatRoomMessageProtocol(
          message: message!,
        );
      case 'empty':
        return const ChatRoomMessageEmpty();
      default:
        return const Text('Unknown message type');
    }
  }
}
