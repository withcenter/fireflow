import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatRoomMessageMine extends StatelessWidget {
  const ChatRoomMessageMine({
    super.key,
    required this.message,
  });

  final ChatRoomMessagesRecord message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: Colors.yellow.shade700.withAlpha(128),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Text(
            message.text ?? '',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
