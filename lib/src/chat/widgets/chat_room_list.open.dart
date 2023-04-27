import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class ChatRoomListOpen extends StatelessWidget {
  const ChatRoomListOpen({
    super.key,
    required this.onTap,
  });

  final void Function(ChatRoomModel room) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.blue),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text('오픈챗',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                const Spacer(),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_add_alt_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PaginateFirestore(
            itemBuilder: (context, snapshots, index) {
              final room = ChatRoomModel.fromSnapshot(snapshots[index]);
              return ChatRoomInfoTile(
                chatRoom: room,
                onTap: onTap,
              );
            },
            query: ChatService.instance.openRooms,
            itemBuilderType: PaginateBuilderType.listView,
            isLive: true,
          ),
        ),
      ],
    );
  }
}
