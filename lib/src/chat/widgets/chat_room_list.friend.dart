import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fireflow/fireflow.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

/// 채팅 방 목록
///
/// 1:1 채팅과 그룹 채팅을 따로 분리해서 보여준다.
///
/// [onTap] 으로 전달(리턴)되는 DocumentSnapshot 은 채팅방의 DocumentSnapshot 이다.
///
class ChatRoomListFriend extends StatelessWidget {
  const ChatRoomListFriend({
    super.key,
    required this.onTap,
  });

  final void Function(DocumentSnapshot doc) onTap;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: ChatService.instance.rooms.where('userDocumentReferences',
          arrayContains: UserService.instance.ref),
      itemBuilder: (context, doc) => ChatService.instance.isGroupChat(doc.id)
          ? GroupChatSticker(
              chatRoomDocumentReference: doc.reference,
              onTap: (groupDoc) => onTap(groupDoc),
            )
          : SingleChatSticker(
              userDocumentReference: ChatService.instance
                  .getOtherUserDocumentReferenceFromChatRoomReference(
                      doc.reference),
              onTap: (pubDoc) => onTap(doc),
            ),
    );
  }
}
