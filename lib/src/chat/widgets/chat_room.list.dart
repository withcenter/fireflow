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
/// TODO: 옵션 추가 - 나의 전체 채팅, 1:1 채팅만, 그룹 채팅만, 즐겨찾기 채팅방 목록, 새로운 메시지가 있는 채팅방 목록
/// TODO: 옵션 추가 - 채팅방 목록 정렬, 방제목, 최근 메시지, 채팅방 참여자 수, 1:1 이름 순, 등
class ChatRoomList extends StatelessWidget {
  const ChatRoomList({
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
