import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatRoomMessage extends StatelessWidget {
  const ChatRoomMessage({
    super.key,
    required this.type,
    required this.snapshot,
  });
  final String type;
  final DocumentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'my':
        return ChatRoomMessageMine(
          message: ChatRoomMessageModel.fromSnapshot(snapshot!),
        );
      case 'other':
        return ChatRoomMessageOthers(
          message: ChatRoomMessageModel.fromSnapshot(snapshot!),
        );
      case 'protocol':
        return ChatRoomMessageProtocol(
          message: ChatRoomMessageModel.fromSnapshot(snapshot!),
        );
      case 'empty':
        return const ChatRoomMessageEmpty();
      default:
        return const Text('Unknown message type');
    }
  }
}
