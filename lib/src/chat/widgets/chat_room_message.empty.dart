import 'package:flutter/material.dart';

class ChatRoomMessageEmpty extends StatelessWidget {
  const ChatRoomMessageEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Oops, There is no messages yet.');
  }
}
