import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

class ChatRoomMessageMine extends StatelessWidget {
  const ChatRoomMessageMine({
    super.key,
    required this.room,
    required this.message,
  });

  final ChatRoomModel room;
  final ChatRoomMessageModel message;

  @override
  Widget build(BuildContext context) {
    /// 채팅 메시지를 오른쪽 정렬하기 위한 Row 컨테이너
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 전체 너비의 70% 를 최대 너비로 제한하는 컨테이너
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// 채팅 메시지가 이미지면 이미지를 표시
              if (message.uploadUrl.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: DisplayMedia(url: message.uploadUrl),
                  ),
                ),

              /// 채팅 메시지
              if (message.text.isNotEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700.withAlpha(128),
                    borderRadius: borderRadius,
                  ),
                  child: Text(
                    message.text,
                    textAlign: TextAlign.right,
                  ),
                ),

              /// URL 미리 보기
            ],
          ),
        )
      ],
    );
  }

  static const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );
}
