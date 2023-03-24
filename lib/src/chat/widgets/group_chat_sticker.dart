import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// 그룹 채팅방 정보 표시 스티커
///
/// 왼쪽에 그룹 관련 사진, 오른쪽에 채팅방 정보(이름, 참여자 수, 최근 메시지, 시간 등)을 표시한다.
///
/// 채팅방 인원이 채팅을 하면, 정보가 실시간으로 변할 수 있다. 그래서 항상 ref 를 입력받아,
/// 실시간으로 정보를 가져와야 한다.
///
/// [onTap] 으로 전달(리턴)되는 DocumentSnapshot 은 채팅방의 DocumentSnapshot 이다.
///
class GroupChatSticker extends StatelessWidget {
  const GroupChatSticker({
    super.key,
    required this.chatRoomDocumentReference,
    required this.onTap,
  });

  final DocumentReference chatRoomDocumentReference;

  final void Function(DocumentSnapshot doc) onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatRoomDocumentReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox.shrink();
          }

          final chatRoom = ChatRoomsRecord.getDocumentFromData(
              snapshot.data!.data() as Map<String, dynamic>,
              snapshot.data!.reference);

          return GestureDetector(
            onTap: () => onTap(snapshot.data!),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 175, 137, 23)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Group chat room'),
                  Text(chatRoom.title == '' ? 'No title' : chatRoom.title!),
                  Text('Chat room: ${chatRoomDocumentReference.id}'),
                ],
              ),
            ),
          );
        });
  }
}
