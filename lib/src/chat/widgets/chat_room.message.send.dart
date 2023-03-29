import 'package:flutter/material.dart';

class ChatRoomMessageSend extends StatefulWidget {
  const ChatRoomMessageSend({
    super.key,
    required this.onUpload,
    required this.onSend,
  });

  final void Function() onUpload;
  final void Function(String) onSend;

  @override
  State<ChatRoomMessageSend> createState() => _ChatRoomMessageSendState();
}

class _ChatRoomMessageSendState extends State<ChatRoomMessageSend> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // add a camera icon button to update a photo into Firebase storage
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: widget.onUpload,
        ),
        Expanded(
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Message',
            ),
            minLines: 1,
            maxLines: 5,
          ),
        ),
        const SizedBox(width: 8),
        // add a send icon button
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            widget.onSend(textController.text);
            textController.clear();
          },
        ),
      ],
    );
  }
}
