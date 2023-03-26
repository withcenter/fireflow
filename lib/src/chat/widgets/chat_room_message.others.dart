import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatRoomMessageOthers extends StatelessWidget {
  const ChatRoomMessageOthers({
    super.key,
    required this.message,
  });

  final ChatRoomMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: Colors.blue.shade100.withAlpha(128),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Text(
            message.text,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
