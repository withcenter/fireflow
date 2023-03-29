import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 채팅방 메시지 목록 & 스크롤
///
/// 반드시, 채팅방 문서의 DocumentReference 를 전달받아야 한다.
/// 채팅방 정보 문서나 모델을 받을 필요가 전혀 없다. 필요한 경우, 채팅방 정보를 생성한다.
///
/// 개선점, 만약, 채팅방 문서를 채팅 목록에서 부터 받아 온다면, 채팅방 화면에는 파라메타로
/// 채팅방 문서(Model)를 가지고 있을 것이다. 그 model 을 이 화면으로 바로 넘기면,
/// [chatRoomExists] 변수를 최대한 빠르게 true 로 설정하여 채팅메시지를 더 빠르게
/// 보여 줄 수 있다. 이것은 채팅 화면 깜빡거림을 한번 줄을 수 있는 것이다.
///
///
class ChatRoomMessageList extends StatefulWidget {
  const ChatRoomMessageList({
    Key? key,
    this.width,
    this.height,
    this.chatRoomDocumentReference,
    this.chatRoom,
    this.myMessageBuilder,
    this.otherMessageBuilder,
    this.onEmpty,
    this.protocolMessageBuilder,
    this.builder,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DocumentReference? chatRoomDocumentReference;
  final ChatRoomModel? chatRoom;

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
  late ChatRoomModel? room;

  StreamSubscription? subscriptionNewMessage;

  /// 채팅방 정보 문서가 존재하는가?
  bool chatRoomExists = false;

  /// 현재 채팅방 문서의 reference
  DocumentReference get roomReference =>
      widget.chatRoomDocumentReference ?? room!.reference;

  /// The chat room document references of the 1:1 chat room between you and the other user.
  List<DocumentReference> get youAndMeRef => roomReference.id
      .split('-')
      .map<DocumentReference>((id) => UserService.instance.doc(id))
      .toList();

  /// 채팅방 ID 에 하이픈(-)이 들어가 있으면 1:1 채팅방. 아니면, 그룹 채팅방이다.
  bool get isSingleChat => roomReference.id.contains('-');

  ///
  bool get isGroupChat => !isSingleChat;

  @override
  void initState() {
    super.initState();

    chatRoomExists = widget.chatRoom != null;
    init();
  }

  /// Initialize the chat room.
  ///
  init() async {
    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomDocumentReference = roomReference;

    if (isSingleChat) {
      /// 1:1 채팅방
      ///
      /// 채팅방이 이전에 생성되어져 있지 않으면 생성. 그리고 자신은 메시지 읽음으로 표시.
      ///
      await ChatService.instance.update(
        roomReference,
        userDocumentReferences: FieldValue.arrayUnion(youAndMeRef),
        lastMessageSeenBy: FieldValue.arrayUnion([myReference]),
        isGroupChat: false,
        isSubChatRoom: false,
      );
    } else {
      /// 그룹 채팅 방 읽기
      room = await ChatService.instance.getRoom(roomReference.id);

      /// 사용자가 방 안에 들어가 있지 않다면?
      ///
      /// 사용자를 추가하고, 입장 메시지를 보낸다.
      if (room != null &&
          room!.userDocumentReferences.contains(myReference) == false &&
          room!.isOpenChat) {
        try {
          await room!.update(
            userDocumentReferences: FieldValue.arrayUnion([myReference]),
          );
        } catch (e) {
          dog('에러 발생: 그룹 채팅방 사용자 추가 $e');
          rethrow;
        }
        try {
          await ChatService.instance.sendMessage(
            chatRoomDocumentReference: roomReference,
            protocol: 'enter',
            protocolTargetUserDocumentReference: myReference,
          );
        } catch (e) {
          dog('에러 발생: 그룹 채팅방 입장 메시지 보내기 $e');
          rethrow;
        }
      }

      /// 그룹 채팅방 업데이트
      ///
      /// open chat 이 아닌 경우에는 다른 사용가 초대해야지만 접속 가능
      /// 채팅 메시지 읽음 표시
      /// sub chat room 인지 표시
      try {
        await ChatService.instance.update(
          roomReference,
          lastMessageSeenBy: FieldValue.arrayUnion([myReference]),
          isGroupChat: true,
          isSubChatRoom: room?.parentChatRoomDocumentReference != null,
        );
      } catch (e) {
        dog('에러 발생: 그룹 채팅방 업데이트 $e');
        rethrow;
      }
    }

    /// 채팅방이 생성되기 전에 메시지를 가져오려고 시도할 수 있는데,
    /// 이를 방지하기 위해서, 채팅방 문서가 존재하는지 확인
    ///
    /// 채팅방 사용이 가능한 상태이면, 화면을 다시 그린다.
    /// 화면 깜빡임을 없애기 위해서, 필요하지 않은 경우, build 하지 않도록 한다.
    if (chatRoomExists == false) {
      setState(() {
        chatRoomExists = true;
      });
    }

    /// 새로운 메시지가 있으면, 읽음 표시.
    subscriptionNewMessage = roomReference.snapshots().listen((snapshot) {
      /// 채팅방 정보 업데이트
      room = ChatRoomModel.fromSnapshot(snapshot);

      /// If the signed-in user have not seen the message, then make it seen.
      if (room!.lastMessageSeenBy.contains(myReference) == false) {
        room!.update(lastMessageSeenBy: FieldValue.arrayUnion([myReference]));
      }
    }, onError: (e) {
      dog('에러 발생: 채팅방 메시지 읽음 표시 $e');
      throw e;
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
    if (chatRoomExists == false) return const SizedBox.shrink();
    return PaginateFirestore(
      reverse: true,

      itemBuilder: (context, documentSnapshots, index) {
        final snapshot = documentSnapshots[index];

        final message = ChatRoomMessageModel.fromSnapshot(snapshot);

        if (message.protocol.isNotEmpty) {
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
          .where('chatRoomDocumentReference', isEqualTo: roomReference)
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
        message: ChatRoomMessageModel.fromSnapshot(snapshot),
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
        message: ChatRoomMessageModel.fromSnapshot(snapshot),
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
        message: ChatRoomMessageModel.fromSnapshot(snapshot),
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
