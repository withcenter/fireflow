import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatRoomMessageProtocol extends StatelessWidget {
  const ChatRoomMessageProtocol({
    super.key,
    required this.message,
  });

  final ChatRoomMessageModel message;

  @override
  Widget build(BuildContext context) {
    /// TODO 프로토콜 초대, 퇴장, 강퇴 처리.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
        ),
        const SizedBox(width: 16),
        if (message.protocol == ChatProtocol.enter.name)
          UserDoc(
            reference: message.protocolTargetUserDocumentReference!,
            builder: (user) => Text(
              "${user.displayName}님이 입장하셨습니다.",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
