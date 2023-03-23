import 'dart:async';

import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/backend/schema/chat_room_messages_record.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// ChatRoomMessageList is a widget that displays a list of messages in a chat room.
///
class ChatRoomMessageList extends StatefulWidget {
  const ChatRoomMessageList({
    Key? key,
    this.width,
    this.height,
    required this.chatRoomDocumentReference,
    required this.myMessageBuilder,
    required this.otherMessageBuilder,
    required this.onEmpty,
    this.protocolMessageBuilder,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DocumentReference chatRoomDocumentReference;

  final Widget Function(DocumentSnapshot) myMessageBuilder;
  final Widget Function(DocumentSnapshot) otherMessageBuilder;
  final Widget Function(DocumentSnapshot)? protocolMessageBuilder;
  final Widget onEmpty;

  @override
  ChatRoomMessageListState createState() => ChatRoomMessageListState();
}

class ChatRoomMessageListState extends State<ChatRoomMessageList> {
  DocumentReference get myReference => UserService.instance.ref;

  /// The chat room model.
  ///
  /// This is updated when the chat room is updated.
  late ChatRoomModel room;

  late final StreamSubscription subscriptionNewMessage;

  /// Ensure the chat room exists.
  bool ensureChatRoomExists = false;

  /// The chat room document references of the 1:1 chat room between you and the other user.
  List<DocumentReference> get youAndMeRef => widget.chatRoomDocumentReference.id
      .split('-')
      .map((id) => UserService.instance.doc(id))
      .toList();

  /// The chat room document reference.
  DocumentReference get chatRoomRef => widget.chatRoomDocumentReference;

  /// 채팅방 ID 에 하이픈(-)이 들어가 있으면 1:1 채팅방. 아니면, 그룹 채팅방이다.
  bool get isSingleChat => widget.chatRoomDocumentReference.id.contains('-');

  ///
  bool get isGroupChat => !isSingleChat;

  @override
  void initState() {
    super.initState();

    init();
  }

  /// Initialize the chat room.
  ///
  init() async {
    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomDocumentReference = chatRoomRef;

    if (isSingleChat) {
      // For 1:1 chat,
      //  - create a chat room if it does not exist.
      //  - just make the last message seen by you.
      /// Note that, this may produce a permission error on update. It's again the rule.
      await chatRoomRef.set(
        {
          'userDocumentReferences': youAndMeRef,
          'lastMessageSeenBy': FieldValue.arrayUnion([myReference]),
          'isGroupChat': false,
          'isSubChatRoom': false,
          'id': chatRoomRef.id,
        },
        SetOptions(merge: true),
      );
    } else {
      // For the open group chat, any user can join the chat room.

      // get the room
      room = ChatRoomModel.fromSnapshot(await chatRoomRef.get());

      // If the user is not in the room, and the room is open chat, then add the user's ref to the room.
      // And send a message for 'enter'.
      if (room.userDocumentReferences.contains(myReference) == false &&
          room.isOpenChat == true) {
        await chatRoomRef.update({
          'userDocumentReferences': FieldValue.arrayUnion([myReference]),
        });
        await ChatService.instance.sendMessage(
          chatRoomDocumentReference: chatRoomRef,
          protocol: 'enter',
          protocolTargetUserDocumentReference: myReference,
        );
      }

      // For group chat,
      //  - users can only invited by other user.
      //  - just make the last message seen by you.
      //  - set if the room is sub-group-chat or not.
      await chatRoomRef.update({
        'lastMessageSeenBy': FieldValue.arrayUnion([myReference]),
        'isGroupChat': true,
        'isSubChatRoom': room.parentChatRoomDocumentReference != null,
        'id': chatRoomRef.id,
      });
    }

    /// When the chat begins, the app try to get messages before the chat room exists.
    /// This may lead permission error and showing an infinite loader.
    /// Rebuiding the screen helps to avoid the infinite loader.
    setState(() {
      ensureChatRoomExists = true;
    });

    // Listen for new message, and make it read by you.
    subscriptionNewMessage = chatRoomRef.snapshots().listen((snapshot) {
      room = ChatRoomModel.fromSnapshot(snapshot);

      /// If the signed-in user have not seen the message, then make it seen.
      if (room.lastMessageSeenBy.contains(myReference) == false) {
        chatRoomRef.update({
          'lastMessageSeenBy': FieldValue.arrayUnion([myReference])
        });
      }
    });
  }

  @override
  void dispose() {
    AppService.instance.currentChatRoomDocumentReference = null;
    subscriptionNewMessage.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ensureChatRoomExists == false) return const SizedBox.shrink();
    return PaginateFirestore(
      reverse: true,

      itemBuilder: (context, documentSnapshots, index) {
        final snapshot = documentSnapshots[index];

        final message = ChatRoomMessagesRecord.getDocumentFromData(
            snapshot.data() as Map<String, dynamic>, snapshot.reference);

        // final message =

        if (message.protocol!.isNotEmpty) {
          if (widget.protocolMessageBuilder != null) {
            return widget.protocolMessageBuilder!(snapshot);
          } else {
            return const SizedBox.shrink();
          }
        } else if (message.userDocumentReference == myReference) {
          return widget.myMessageBuilder(snapshot);
        } else {
          return widget.otherMessageBuilder(snapshot);
        }
      },

      /// Get messages of the chat room.
      query: FirebaseFirestore.instance
          .collection('chat_room_messages')
          .where('chatRoomDocumentReference', isEqualTo: chatRoomRef)
          .orderBy('sentAt', descending: true),
      // Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // To fetch real-time data
      isLive: true,
      onEmpty: widget.onEmpty,
      initialLoader: const SizedBox.shrink(),
      bottomLoader: const SizedBox.shrink(),
    );
  }
}
