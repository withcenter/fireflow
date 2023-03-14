import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
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
    this.otherUserPublicDataDocument,
    this.chatRoomDocumentReference,
    required this.onMyMessage,
    required this.onOtherMessage,
    required this.onEmpty,
    this.onProtocolMessage,
  })  : assert(chatRoomDocumentReference != null,
            "You must set only one of otherUserPublicDataDocument or chatRoomDocumentReference."),
        super(key: key);

  final double? width;
  final double? height;
  final DocumentReference? otherUserPublicDataDocument;
  final DocumentReference? chatRoomDocumentReference;

  final Widget Function(ChatRoomMessageModel) onMyMessage;
  final Widget Function(ChatRoomMessageModel) onOtherMessage;
  final Widget Function(ChatRoomMessageModel)? onProtocolMessage;
  final Widget onEmpty;

  @override
  _ChatRoomMessageListState createState() => _ChatRoomMessageListState();
}

class _ChatRoomMessageListState extends State<ChatRoomMessageList> {
  DocumentReference get myReference => UserService.instance.ref;

  /// The chat room model.
  ///
  /// This is updated when the chat room is updated.
  late ChatRoomModel room;

  late final StreamSubscription subscriptionNewMessage;

  /// Ensure the chat room exists.
  bool ensureChatRoomExists = false;

  UserPublicDataModel get my => UserService.instance.my;

  /// The chat room document references of the 1:1 chat room between you and the other user.
  List<DocumentReference> get youAndMeRef => [
        UserService.instance.doc(widget.otherUserPublicDataDocument!.id),
        myReference,
      ];

  /// The chat room document reference.
  DocumentReference get chatRoomRef {
    if (isGroupChat) {
      return widget.chatRoomDocumentReference!;
    } else {
      return ChatService.instance.room(
          ([my.uid, widget.otherUserPublicDataDocument!.id]..sort()).join('-'));
    }
  }

  bool get isSingleChat => widget.otherUserPublicDataDocument != null;

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
      // item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final message =
            ChatRoomMessageModel.fromSnapshot(documentSnapshots[index]);

        if (message.isProtocol) {
          if (widget.onProtocolMessage != null) {
            return widget.onProtocolMessage!(message);
          } else {
            return const SizedBox.shrink();
          }
        } else if (message.isMine) {
          return widget.onMyMessage(message);
        } else {
          return widget.onOtherMessage(message);
        }
      },

      /// Get messages of the chat room.
      query: FirebaseFirestore.instance
          .collection('chat_room_messages')
          .where('chatRoomDocumentReference', isEqualTo: chatRoomRef)
          .orderBy('sentAt', descending: true),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
      onEmpty: widget.onEmpty,
      initialLoader: const SizedBox.shrink(),
      bottomLoader: const SizedBox.shrink(),
    );
  }
}
