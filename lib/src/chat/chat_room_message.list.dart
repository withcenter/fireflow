import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// ChatRoomMessageList is a widget that displays a list of messages in a chat room.
///
class ChatRoomMessageList extends StatefulWidget {
  const ChatRoomMessageList({
    Key? key,
    this.width,
    this.height,
    this.otherUserDocumentReference,
    this.chatRoomDocumentReference,
    required this.onMyMessage,
    required this.onOtherMessage,
    required this.onEmpty,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DocumentReference? otherUserDocumentReference;
  final DocumentReference? chatRoomDocumentReference;

  final Widget Function(Map<String, dynamic>, DocumentReference) onMyMessage;
  final Widget Function(
          DocumentReference, Map<String, dynamic>, DocumentReference)
      onOtherMessage;
  final Widget onEmpty;

  @override
  _ChatRoomMessageListState createState() => _ChatRoomMessageListState();
}

class _ChatRoomMessageListState extends State<ChatRoomMessageList> {
  //
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference get userCol => db.collection('users');
  User get my => FirebaseAuth.instance.currentUser!;
  DocumentReference get myReference => userCol.doc(my.uid);

  final chatCol = FirebaseFirestore.instance.collection('chat_rooms');

  late final Map<String, dynamic> chat;

  late final subscriptionNewMessage;

  // 1:1 채팅에서 나와 상대방의 ref 배열
  List<DocumentReference> get youAndMeRef => [
        userCol.doc(widget.otherUserDocumentReference!.id),
        myReference,
      ];

  // 채팅 방 ref
  DocumentReference get chatRoomRef {
    if (isGroupChat) {
      return widget.chatRoomDocumentReference!;
    } else {
      final arr = [my.uid, widget.otherUserDocumentReference!.id];
      arr.sort();
      return db.collection('chat_rooms').doc(arr.join('-'));
    }
  }

  bool get isGroupChat => widget.chatRoomDocumentReference != null;
  bool get isSingleChat => !isGroupChat;

  DocumentReference getUserDocumentReference(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid);
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  /// Initialize the chat room.
  ///
  init() async {
    // My user document ref
    final myRef = getUserDocumentReference(my.uid);

    // // Query the chat room (To see if it exists)
    // final snapshot =
    //     await chatCol.where('chatRoomId', isEqualTo: widget.chatRoomId).get();

    //
    final roomSnapshot = await chatRoomRef.get();

    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomReference = chatRoomRef;

    // Create chat room document if it does not exists.
    if (roomSnapshot.exists == false) {
      if (isSingleChat) {
        await chatRoomRef.set({
          'users': youAndMeRef,
        });
      } else {
        await chatRoomRef.set({
          'users': [myReference],
        });
      }
    }

    // Update chat room information
    //
    // You are entering the chat room. So, make it read by you.
    chatRoomRef.update({
      'lastMessageSeenBy': FieldValue.arrayUnion([myRef])
    });

    // Listen for new message, and make it read by you.
    subscriptionNewMessage = chatRoomRef.snapshots().listen((snapshot) {
      final room = ChatRoomModel.fromSnapshot(snapshot);

      /// If the signed-in user have not seen the message, then make it seen.
      if (room.lastMessageSeenBy.contains(myRef) == false) {
        chatRoomRef.update({
          'lastMessageSeenBy': FieldValue.arrayUnion([myRef])
        });
      }
    });
  }

  @override
  void dispose() {
    AppService.instance.currentChatRoomReference = null;
    subscriptionNewMessage.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      reverse: true,
      // item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final DocumentSnapshot doc = documentSnapshots[index];
        final data = doc.data() as Map<String, dynamic>;

        final currentUser = FirebaseAuth.instance.currentUser!;

        if (data['senderUserDocumentReference'] ==
            getUserDocumentReference(currentUser.uid)) {
          return widget.onMyMessage(
            data,
            doc.reference,
          );
          // return ChatMyMessageWidget(
          //   chatRoomMessage: ChatRoomMessageListRecord.getDocumentFromData(
          //     data,
          //     doc.reference,
          //   ),
          // );
        } else {
          return widget.onOtherMessage(
            chatRoomRef,
            data,
            doc.reference,
          );
          // return ChatOtherUserMessageWidget(
          //   chatRoomDocumentReference: widget.chatRoomDocumentReference,
          //   chatRoomMessageDocument:
          //       ChatRoomMessageListRecord.getDocumentFromData(
          //     data,
          //     doc.reference,
          //   ),
          // );
        }
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance
          .collection('chat_room_messages')
          .where('chatRoomDocumentReferenceReference', isEqualTo: chatRoomRef)
          .orderBy('timestamp', descending: true),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
      onEmpty: widget.onEmpty,
    );
  }
}
