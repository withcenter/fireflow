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
    this.otherUserPublicDataDocument,
    this.chatRoomDocumentReference,
    required this.onMyMessage,
    required this.onOtherMessage,
    required this.onEmpty,
  })  : assert(
            (otherUserPublicDataDocument != null &&
                    chatRoomDocumentReference == null) ||
                (otherUserPublicDataDocument == null &&
                    chatRoomDocumentReference != null),
            "You must set only one of otherUserPublicDataDocument or chatRoomDocumentReference."),
        super(key: key);

  final double? width;
  final double? height;
  final DocumentReference? otherUserPublicDataDocument;
  final DocumentReference? chatRoomDocumentReference;

  final Widget Function(ChatRoomMessageModel) onMyMessage;
  final Widget Function(ChatRoomMessageModel) onOtherMessage;
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
        userCol.doc(widget.otherUserPublicDataDocument!.id),
        myReference,
      ];

  // 채팅 방 ref
  DocumentReference get chatRoomRef {
    if (isGroupChat) {
      return widget.chatRoomDocumentReference!;
    } else {
      final arr = [my.uid, widget.otherUserPublicDataDocument!.id];
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

    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomReference = chatRoomRef;

    if (isSingleChat) {
      // For 1:1 chat,
      //  - create a chat room if it does not exist.
      //  - just make the last message seen by you.
      await chatRoomRef.set({
        'users': youAndMeRef,
        'lastMessageSeenBy': FieldValue.arrayUnion([myRef]),
      }, SetOptions(merge: true));
    } else {
      // For group chat,
      //  - users can only invited by other user.
      //  - just make the last message seen by you.
      await chatRoomRef.update({
        'lastMessageSeenBy': FieldValue.arrayUnion([myRef]),
      });
    }

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
        final message =
            ChatRoomMessageModel.fromSnapshot(documentSnapshots[index]);

        if (message.isMine) {
          return widget.onMyMessage(message);
        } else {
          return widget.onOtherMessage(message);
        }
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance
          .collection('chat_room_messages')
          .where('chatRoomDocumentReference', isEqualTo: chatRoomRef)
          .orderBy('sentAt', descending: true),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
      onEmpty: widget.onEmpty,
    );
  }
}
