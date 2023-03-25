import 'dart:async';

import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

/// ChatRoomMessageList is a widget that displays a list of messages in a chat room.
///
class ChatRoomMessageList extends StatefulWidget {
  const ChatRoomMessageList({
    Key? key,
    this.width,
    this.height,
    required this.chatRoomDocumentReference,
    this.myMessageBuilder,
    this.otherMessageBuilder,
    this.onEmpty,
    this.protocolMessageBuilder,
    this.builder,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DocumentReference chatRoomDocumentReference;

  final Widget Function(DocumentSnapshot)? myMessageBuilder;
  final Widget Function(DocumentSnapshot)? otherMessageBuilder;
  final Widget Function(DocumentSnapshot)? protocolMessageBuilder;
  final Widget? onEmpty;

  final Widget Function(String type, DocumentSnapshot?)? builder;

  @override
  ChatRoomMessageListState createState() => ChatRoomMessageListState();
}

class ChatRoomMessageListState extends State<ChatRoomMessageList> {
  DocumentReference get myReference => UserService.instance.ref;

  /// The chat room model.
  ///
  /// This is updated when the chat room is updated.
  late ChatRoomsRecord room;

  StreamSubscription? subscriptionNewMessage;

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

      // 채팅방 정보 읽기 & 에러 핸들링.
      try {
        room = await ChatRoomsRecord.getDocumentOnce(chatRoomRef);
      } catch (e) {
        snackBarError(
            context: context,
            title: 'Failed to get chat room',
            message:
                'The chat room does not exists. Or it may be a wrong chat room reference. Or you do not have permission to access the chat room.');
        rethrow;
      }

      // If the user is not in the room, and the room is open chat, then add the user's ref to the room.
      // And send a message for 'enter'.
      if (room.userDocumentReferences!.contains(myReference) == false &&
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
      room = ChatRoomsRecord.getDocumentFromData(
          snapshot.data() as Map<String, dynamic>, snapshot.reference);

      // room = ChatRoomModel.fromSnapshot(snapshot);

      /// If the signed-in user have not seen the message, then make it seen.
      if (room.lastMessageSeenBy!.contains(myReference) == false) {
        chatRoomRef.update({
          'lastMessageSeenBy': FieldValue.arrayUnion([myReference])
        });
      }
    });
  }

  @override
  void dispose() {
    AppService.instance.currentChatRoomDocumentReference = null;
    subscriptionNewMessage?.cancel();
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

        if (message.protocol!.isNotEmpty) {
          return protocolMessageBuilder(snapshot);
        } else if (message.userDocumentReference == myReference) {
          return myMessageBuilder(snapshot);
        } else {
          return otherMessageBuilder(snapshot);
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
      onEmpty: emptyWidget(),
      initialLoader: const SizedBox.shrink(),
      bottomLoader: const SizedBox.shrink(),
    );
  }

  /// 내 메시지를 내가 보는 경우, widget builder
  Widget myMessageBuilder(DocumentSnapshot snapshot) {
    if (widget.builder != null) {
      return widget.builder!('my', snapshot);
    }
    if (widget.myMessageBuilder != null) {
      return widget.myMessageBuilder!(snapshot);
    } else {
      return ChatRoomMessageMine(
        message: ChatRoomMessagesRecord.getDocumentFromData(
          snapshot.data()! as Map<String, dynamic>,
          snapshot.reference,
        ),
      );
    }
  }

  /// 다른 사람의 메시지를 보는 경우,
  Widget otherMessageBuilder(DocumentSnapshot snapshot) {
    if (widget.builder != null) {
      return widget.builder!('other', snapshot);
    }
    if (widget.otherMessageBuilder != null) {
      return widget.otherMessageBuilder!(snapshot);
    } else {
      return ChatRoomMessageOthers(
        message: ChatRoomMessagesRecord.getDocumentFromData(
          snapshot.data()! as Map<String, dynamic>,
          snapshot.reference,
        ),
      );
    }
  }

  Widget protocolMessageBuilder(DocumentSnapshot snapshot) {
    if (widget.builder != null) {
      return widget.builder!('protocol', snapshot);
    }
    if (widget.protocolMessageBuilder != null) {
      return widget.protocolMessageBuilder!(snapshot);
    } else {
      return ChatRoomMessageProtocol(
        message: ChatRoomMessagesRecord.getDocumentFromData(
          snapshot.data()! as Map<String, dynamic>,
          snapshot.reference,
        ),
      );
    }
  }

  /// 채팅방에 채팅 메시지가 없을 때, 보여줄 위젯.
  Widget emptyWidget() {
    if (widget.builder != null) {
      return widget.builder!('empty', null);
    }
    return widget.onEmpty ?? const ChatRoomMessageEmpty();
  }
}
