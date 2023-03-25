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
          message: ChatRoomMessagesRecord.getDocumentFromData(
            snapshot!.data()! as Map<String, dynamic>,
            snapshot!.reference,
          ),
        );
      case 'other':
        return ChatRoomMessageOthers(
          message: ChatRoomMessagesRecord.getDocumentFromData(
            snapshot!.data()! as Map<String, dynamic>,
            snapshot!.reference,
          ),
        );
      case 'protocol':
        return ChatRoomMessageProtocol(
          message: ChatRoomMessagesRecord.getDocumentFromData(
            snapshot!.data()! as Map<String, dynamic>,
            snapshot!.reference,
          ),
        );
      case 'empty':
        return const ChatRoomMessageEmpty();
      default:
        return const Text('Unknown message type');
    }
  }
}
