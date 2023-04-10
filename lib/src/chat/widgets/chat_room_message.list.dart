import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

/// 채팅방 메시지 목록 & 스크롤
///
/// 반드시, 채팅방이 미리 존재해야 하며, 채팅방 모델 ChatRoomModel 을 전달받아야 한다.
///
///
///
class ChatRoomMessageList extends StatefulWidget {
  const ChatRoomMessageList({
    Key? key,
    this.width,
    this.height,
    required this.room,
    this.myMessageBuilder,
    this.otherMessageBuilder,
    this.onEmpty,
    this.protocolMessageBuilder,
    this.builder,
  }) : super(key: key);

  final double? width;
  final double? height;
  final ChatRoomModel room;

  final Widget Function(ChatRoomMessageModel)? myMessageBuilder;
  final Widget Function(ChatRoomMessageModel)? otherMessageBuilder;
  final Widget Function(ChatRoomMessageModel)? protocolMessageBuilder;
  final Widget? onEmpty;

  final Widget Function(String type, ChatRoomMessageModel?)? builder;

  @override
  ChatRoomMessageListState createState() => ChatRoomMessageListState();
}

class ChatRoomMessageListState extends State<ChatRoomMessageList> {
  DocumentReference get myReference => UserService.instance.ref;

  StreamSubscription? subscriptionNewMessage;

  /// The chat room document references of the 1:1 chat room between you and the other user.
  List<DocumentReference> get youAndMeRef => widget.room.id
      .split('-')
      .map<DocumentReference>((id) => UserService.instance.doc(id))
      .toList();

  /// 채팅방 ID 에 하이픈(-)이 들어가 있으면 1:1 채팅방. 아니면, 그룹 채팅방이다.
  bool get isSingleChat => widget.room.id.contains('-');

  ///
  bool get isGroupChat => !isSingleChat;

  @override
  void initState() {
    super.initState();

    /// aysnc/await 을 하지 않으므로, 빠르게 채팅방 목록을 보여준다.
    init();
  }

  /// 채팅방 각종 초기화
  ///
  init() async {
    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomDocumentReference =
        widget.room.reference;

    if (isSingleChat) {
      /// 1:1 채팅방
      ///
      /// - 나를 채팅방에 추가하고,
      /// - 메세지 읽음 표시
      await ChatService.instance.upsert(
        widget.room.reference,
        userDocumentReferences: FieldValue.arrayUnion(youAndMeRef),
        lastMessageSeenBy: FieldValue.arrayUnion([myReference]),
        isGroupChat: false,
        isSubChatRoom: false,
      );
    } else {
      /// 그룹 채팅 방 읽기
      ///
      /// - 그리고 오픈챗인 경우에만,
      /// - 그리고 내가 그 방에 들어가 있지 않으면
      /// 나를 추가를 한다.

      await ChatService.instance.enter(room: widget.room);

      /// 그룹 채팅방 업데이트
      ///
      /// - 나를 채팅방에 추가하고, (open chat 이 아닌 경우에는 다른 사용가 초대해야지만 접속 가능)
      /// - 읽음 표시
      /// - group chat, subgroup chat 인지 표시
      ///
      try {
        await ChatService.instance.upsert(
          widget.room.reference,
          lastMessageSeenBy: FieldValue.arrayUnion([myReference]),
          isGroupChat: true,
          isSubChatRoom: widget.room.parentChatRoomDocumentReference != null,
        );
      } catch (e) {
        dog('에러 발생: 그룹 채팅방 업데이트 $e');
        rethrow;
      }
    }

    /// 채팅방 정보가 업데이트되면, rebuild
    /// - 새로운 메시지가 있으면, 읽음 표시.
    /// 참고, 채팅방이 반드시 존재하는 상태이므로, 아래와 같이 listen 해도 security rules 통과 됨.
    subscriptionNewMessage =
        widget.room.reference.snapshots().listen((snapshot) {
      /// 채팅방 정보 업데이트
      final room = ChatRoomModel.fromSnapshot(snapshot);

      /// 최신 메시지를 읽은 사용자 목록에 나를 추가
      if (room.lastMessageSeenBy.contains(myReference) == false) {
        room.upsert(lastMessageSeenBy: FieldValue.arrayUnion([myReference]));
      }

      /// 방정보 rebuild
      setState(() {});
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
    /// 채팅방이 존재하는 경우, 채팅 메시지 목록을 가져와 보여준다.
    return PaginateFirestore(
      reverse: true,

      itemBuilder: (context, documentSnapshots, index) {
        final snapshot = documentSnapshots[index];

        final message = ChatRoomMessageModel.fromSnapshot(snapshot);

        /// TODO 이미지/파일 업로드 처리
        if (message.protocol.isNotEmpty) {
          return protocolMessageBuilder(message);
        } else if (message.userDocumentReference == myReference) {
          return myMessageBuilder(message);
        } else {
          return otherMessageBuilder(message);
        }
      },

      /// 채팅방의 메시지 목록 가져오기
      query: FirebaseFirestore.instance
          .collection('chat_room_messages')
          .where('chatRoomDocumentReference', isEqualTo: widget.room.reference)
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
  Widget myMessageBuilder(ChatRoomMessageModel message) {
    if (widget.builder != null) {
      return widget.builder!('my', message);
    }
    if (widget.myMessageBuilder != null) {
      return widget.myMessageBuilder!(message);
    } else {
      return ChatRoomMessageMine(
        room: widget.room,
        message: message,
      );
    }
  }

  /// 다른 사람의 메시지를 보는 경우,
  Widget otherMessageBuilder(ChatRoomMessageModel message) {
    if (widget.builder != null) {
      return widget.builder!('other', message);
    }
    if (widget.otherMessageBuilder != null) {
      return widget.otherMessageBuilder!(message);
    } else {
      return ChatRoomMessageOthers(
        message: message,
      );
    }
  }

  Widget protocolMessageBuilder(ChatRoomMessageModel message) {
    if (widget.builder != null) {
      return widget.builder!('protocol', message);
    }
    if (widget.protocolMessageBuilder != null) {
      return widget.protocolMessageBuilder!(message);
    } else {
      return ChatRoomMessageProtocol(
        message: message,
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
