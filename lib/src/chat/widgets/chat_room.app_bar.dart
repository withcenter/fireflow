import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

class ChatRoomAppBar extends StatefulWidget {
  const ChatRoomAppBar({
    super.key,
    required this.chatRoom,
    required this.onLeave,
  });

  final ChatRoomModel chatRoom;
  final VoidCallback onLeave;

  @override
  State<ChatRoomAppBar> createState() => _ChatRoomAppBarState();
}

class _ChatRoomAppBarState extends State<ChatRoomAppBar> {
  ChatRoomModel get room => widget.chatRoom;
  @override
  Widget build(BuildContext context) {
    return UserDoc(
      reference: ChatService.instance
          .getOtherUserDocumentReferenceFromChatRoomReference(room.reference),
      builder: (user) => Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          UserAvatar(
            user: user,
            padding: const EdgeInsets.only(right: 8),
          ),
          Expanded(
            child: Text(user.displayName),
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
              ))
        ],
      ),
    );
  }
}
