import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 채팅 메시지 전송
///
/// [onSend] 는 옵션이다. 직접 콜백 핸들러를 지정해서, 아래와 같이 메시지를 전송 할 수 있으며,
/// 생략을 하면 Fireflow 가 알아서 메시지를 전송한다.
/// ```dart
/// ChatRoomMessageSend(
///   onSend: (text) {
///     ChatService.instance.sendMessage(
///       chatRoomDocumentReference: widget.chatRoomDocumentReference,
///       text: text,
///     );
///   },
/// ),
/// ```
class ChatRoomMessageSend extends StatefulWidget {
  const ChatRoomMessageSend({
    super.key,
    required this.room,
    required this.onUpload,
    this.onSend,
  });

  final ChatRoomModel room;
  final void Function() onUpload;
  final void Function(String)? onSend;

  @override
  State<ChatRoomMessageSend> createState() => _ChatRoomMessageSendState();
}

class _ChatRoomMessageSendState extends State<ChatRoomMessageSend> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 사진 업로드 버튼
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: widget.onUpload,
        ),

        /// 메시지 입력 텍스트 필드
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
        // 메시지 전송 버튼
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            final String text = textController.text;
            if (widget.onSend != null) {
              widget.onSend!(text);
            } else {
              ChatService.instance.sendMessage(
                chatRoomDocumentReference: widget.room.reference,
                text: text,
              );
            }
            textController.clear();
          },
        ),
      ],
    );
  }
}
