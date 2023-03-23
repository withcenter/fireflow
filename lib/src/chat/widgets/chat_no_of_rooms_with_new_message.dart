import 'dart:async';

import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatNoOfRoomsWithNewMessage extends StatefulWidget {
  const ChatNoOfRoomsWithNewMessage({
    Key? key,
    this.width,
    this.height,
    this.textSize,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? textSize;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  ChatNoOfRoomsWithNewMessageState createState() =>
      ChatNoOfRoomsWithNewMessageState();
}

class ChatNoOfRoomsWithNewMessageState
    extends State<ChatNoOfRoomsWithNewMessage> {
  StreamSubscription? subscription;
  // List<ChatRoomModel>? chatRooms;
  int count = 0;

  @override
  void initState() {
    super.initState();

    subscription = ChatService.instance.myRooms.snapshots().listen((snapshot) {
      count = 0;
      if (snapshot.size == 0) {
        return;
      }
      for (final doc in snapshot.docs) {
        final room = ChatRoomModel.fromSnapshot(doc);
        if (room.lastMessage.isNotEmpty &&
            room.lastMessageSeenBy.isNotEmpty &&
            room.lastMessageSeenBy.contains(UserService.instance.ref) ==
                false) {
          count++;
        }
      }
      setState(() {});
    });
  }

  @override
  dispose() {
    subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox.shrink();
    }
    return Container(
      width: widget.width ?? 16,
      height: widget.height ?? 16,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? const Color(0xFFFF4B4B),
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: const Alignment(0, 0),
        child: Text(
          count.toString(),
          style: TextStyle(
            color: widget.textColor ?? const Color(0xFFFFFFFF),
            fontSize: widget.textSize ?? 12,
          ),
        ),
      ),
    );
  }
}
