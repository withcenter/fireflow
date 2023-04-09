import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

/// 채팅방 상단 헤더
class ChatRoomAppBar extends StatefulWidget {
  const ChatRoomAppBar({
    super.key,
    required this.chatRoomDocumentReference,
    required this.onLeave,
  });

  final DocumentReference chatRoomDocumentReference;
  final VoidCallback onLeave;

  @override
  State<ChatRoomAppBar> createState() => _ChatRoomAppBarState();
}

class _ChatRoomAppBarState extends State<ChatRoomAppBar> {
  ChatRoomModel? _room;
  ChatRoomModel get room => _room!;

  bool get isGroupChat => room.isGroupChat;

  StreamSubscription? _roomSubscription;

  DocumentReference get otherUserReference => ChatService.instance
      .getOtherUserDocumentReferenceFromChatRoomReference(room.reference);

  @override
  void initState() {
    super.initState();

    /// 반짝임 방지를 위해서, 상단 앱바를 최대한 적게 랜더링한다.
    _roomSubscription = ChatService.instance.rooms
        .where('userDocumentReferences', arrayContains: my.reference)
        .where('id', isEqualTo: widget.chatRoomDocumentReference.id)
        .limit(1)
        .snapshots()

        /// 마지막 채팅 메시지가 다르면 방 업데이트
        .distinct((prev, next) =>
            prev.size > 0 &&
            (prev.docs.first.data() as Map)['lastMessage'] ==
                (next.docs.first.data() as Map)['lastMessage'])
        .listen((snapshot) {
      if (snapshot.size == 0) {
        return;
      }

      setState(() {
        _room = ChatRoomModel.fromSnapshot(snapshot.docs.first);
        log(_room.toString());
      });
    });
  }

  @override
  void dispose() {
    _roomSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_room == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        /// 채팅방 사진. 1:1 채팅 또는 그룹 채팅방 사진
        room.isGroupChat
            ?

            /// 그룹 채팅
            GroupChatUserPhotos(room: room)
            // Text(room.title)

            /// 1:1 채팅
            : UserDoc(
                reference: otherUserReference,
                builder: (user) => UserAvatar(
                  user: user,
                  padding: const EdgeInsets.only(right: 8),
                ),
              ),
        const SizedBox(width: 8),

        /// 채팅방 제목 및 기타 메타
        Expanded(
          child: isGroupChat
              ? Text(room.title)
              : UserDoc(
                  reference: otherUserReference,
                  builder: (user) => Text(user.displayName)),
        ),
        CustomIconPopup(
          icon: const Icon(Icons.settings),
          iconPadding: 12,
          popup: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ]),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_none_outlined),
                  title: Text(ln('favorite_label')),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_none_outlined),
                  title: Text(ln('notification')),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_circle_right_outlined),
                  title: const Text('나가기'),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onLeave();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
