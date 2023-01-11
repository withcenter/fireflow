import 'dart:async';

import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class ChatNoOfRoomsWithNewMessage extends StatefulWidget {
  const ChatNoOfRoomsWithNewMessage({
    Key? key,
    required this.width,
    required this.height,
    this.textSize = 12,
    this.backgroundColor = const Color(0xFFFF4B4B),
    this.textColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  final double width;
  final double height;
  final double textSize;
  final Color backgroundColor;
  final Color textColor;

  @override
  _ChatNoOfRoomsWithNewMessageState createState() =>
      _ChatNoOfRoomsWithNewMessageState();
}

class _ChatNoOfRoomsWithNewMessageState
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
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: const Alignment(0, 0),
        child: Text(
          count.toString(),
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.textSize,
          ),
        ),
      ),
    );
  }
}
