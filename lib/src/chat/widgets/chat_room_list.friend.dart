import 'package:flutter/material.dart';

import 'package:fireflow/fireflow.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

/// 채팅 방 목록
///
/// 1:1 채팅과 그룹 채팅을 따로 분리해서 보여준다.
///
///
class ChatRoomListFriend extends StatelessWidget {
  const ChatRoomListFriend({
    super.key,
    required this.onTap,
  });

  final void Function(ChatRoomModel room) onTap;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: ChatService.instance.rooms.where('userDocumentReferences',
          arrayContains: UserService.instance.ref),
      itemBuilder: (context, snapshot) => ChatRoomInfoTile(
        chatRoom: ChatRoomModel.fromSnapshot(snapshot),
        onTap: (chatRoom) => onTap(chatRoom),
      ),
    );
  }
}
