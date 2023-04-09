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
/// [chatRoom] 또는 [chatRoomDocumentReference] 둘 중 하나는 입력 되어야 한다.
///
/// [chatRoom] 용도는 단순하다.
/// 채팅방 문서인 chatRoom 을 채팅 목록에서 부터 받아 온다면, 채팅방 정보가 이미 존재한다는 것이므로,
/// [chatRoomExists] 변수를 최대한 빠르게 true 로 설정하여 채팅메시지를 (조금 더) 빠르게
/// 보여준다. 이것은 채팅 화면 깜빡거림을 한번 줄을 수 있는 것이다.
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
  }) :
        // assert(chatRoom != null || chatRoomDocumentReference != null),
        super(key: key);

  final double? width;
  final double? height;
  final DocumentReference? chatRoomDocumentReference;
  final ChatRoomModel? chatRoom;

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

    /// [widget.chatRoom] 이 존재하면, 이미 채팅방이 존재하는 것이므로 빠르게 채팅 메시지 목록을 보여준다.
    chatRoomExists = widget.chatRoom != null;

    /// aysnc/await 을 하지 않으므로, 빠르게 채팅방 목록을 보여준다.
    init();
  }

  /// 채팅방 초기화
  ///
  init() async {
    // Set the chat room ref where I am chat in
    AppService.instance.currentChatRoomDocumentReference = roomReference;

    if (isSingleChat) {
      /// 1:1 채팅방
      ///
      /// 채팅방이 이전에 생성되어져 있지 않으면 생성. 그리고 자신은 메시지 읽음으로 표시.
      ///
      await ChatService.instance.upsert(
        roomReference,
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

      room = await ChatService.instance.getRoom(roomReference.id);

      await ChatService.instance.enter(room: room);

      /// 그룹 채팅방 업데이트
      ///
      /// open chat 이 아닌 경우에는 다른 사용가 초대해야지만 접속 가능
      /// 채팅 메시지 읽음 표시
      /// sub chat room 인지 표시
      try {
        await ChatService.instance.upsert(
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

    /// 채팅방 정보가 업데이트되면, rebuild
    /// - 1:1 채팅에서는 여기서 room 변수가 설정된다. 그룹 채팅은 위에서 room 변수가 설정되었다.
    /// - 새로운 메시지가 있으면, 읽음 표시.
    subscriptionNewMessage = roomReference.snapshots().listen((snapshot) {
      /// 채팅방 정보 업데이트
      room = ChatRoomModel.fromSnapshot(snapshot);

      /// 최신 메시지를 읽은 사용자 목록에 나를 추가
      if (room!.lastMessageSeenBy.contains(myReference) == false) {
        room!.upsert(lastMessageSeenBy: FieldValue.arrayUnion([myReference]));
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
    /// 채팅방이 생성되기 전에는 빈 화면을 보여준다.
    if (chatRoomExists == false) return const SizedBox.shrink();

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
  Widget myMessageBuilder(ChatRoomMessageModel message) {
    if (widget.builder != null) {
      return widget.builder!('my', message);
    }
    if (widget.myMessageBuilder != null) {
      return widget.myMessageBuilder!(message);
    } else {
      return ChatRoomMessageMine(
        room: room!,
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
