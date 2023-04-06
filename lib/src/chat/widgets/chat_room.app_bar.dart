import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _roomSubscription = ChatService.instance.rooms
        .where('userDocumentReferences', arrayContains: my.reference)
        .where('id', isEqualTo: widget.chatRoomDocumentReference.id)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.size == 0) {
        return;
      }
      setState(() {
        _room = ChatRoomModel.fromSnapshot(snapshot.docs.first);
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

        /// 채팅방 이름 또는 상대방 이름
        Expanded(
          child: room.isGroupChat
              ?

              /// 그룹 채팅
              Stack(
                  children: room.userDocumentReferences
                      .map((ref) => UserDoc(
                            reference: ref,
                            builder: (user) => UserAvatar(
                              user: user,
                              padding: const EdgeInsets.only(right: 8),
                            ),
                          ))
                      .toList(),
                )
              // Text(room.title)

              /// 1:1 채팅
              : UserDoc(
                  reference: ChatService.instance
                      .getOtherUserDocumentReferenceFromChatRoomReference(
                          room.reference),
                  builder: (user) => Row(children: [
                    UserAvatar(
                      user: user,
                      padding: const EdgeInsets.only(right: 8),
                    ),
                    Text(isGroupChat ? room.title : user.displayName),
                  ]),
                ),
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
