import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

enum ChatProtocol {
  invite,
  enter,
  leave,
  kick,
}

/// ChatService
///
/// ChatService is a singleton class that provides the chat service.
///
class ChatService {
  static ChatService get instance => _instance ?? (_instance = ChatService());
  static ChatService? _instance;

  /// The Firebase Firestore instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// The collection reference of the chat_rooms collection
  CollectionReference get rooms => db.collection('chat_rooms');

  /// The collection reference of the chat_rooms collection
  CollectionReference get messages => db.collection('chat_room_messages');

  /// Returns a chat room document reference of the given id.
  DocumentReference room(String id) => rooms.doc(id);

  Query get myRooms => rooms.where('userDocumentReferences',
      arrayContains: UserService.instance.ref);

  Query get openRooms => rooms.where('isOpenChat', isEqualTo: true);

  /// Returns a chat room message document reference of the given id.
  DocumentReference message(String id) => messages.doc(id);

  /// 1:1 채팅방 reference 를 리턴
  ///
  /// [otherUserUid]는 상대방의 uid 이다.
  DocumentReference getOneAndOneChatRoomDocumentReference(
    String otherUserUid,
  ) {
    /// Return 1:1 chat room reference
    return rooms.doc(([
      UserService.instance.uid,
      otherUserUid,
    ]..sort())
        .join('-'));
  }

  /// 1:1 채팅방 reference 를 리턴
  ///
  /// 입력값이 다른 사용자의 reference 이다.
  ///
  /// getOneAndOneChatRoomDocumentReference() 와 동일한 결과 리턴
  ///
  DocumentReference getSingChatRoomReference(
    DocumentReference otherUserDocumentReference,
  ) {
    return getOneAndOneChatRoomDocumentReference(otherUserDocumentReference.id);
  }

  /// 채팅 방생성
  ///
  /// 반드시 채팅방(1:1과 그룹 채팅방 모두)은 이 함수 호출을 통해서만 생성해야 한다. FF 에서 직접 레코드를 생성하면 안된다.
  /// 왜냐하면, 채팅방을 생성할 때, 반드시 Chat Room 문서의 ID 가 저장되어야 하기 때문이다.
  ///
  /// isGroupChat, leaveProtocolMessage, urlClick, urlPreview 는 자동 설정된다. 만약, 다른
  /// 값을 원하다면, createRoom() 호출 할 때, data 로 지정하면 된다.
  ///
  ///
  Future<DocumentReference> createRoom({
    DocumentReference? otherUserDocumentReference,
    List<String>? otherUids,
    String? title,
    bool? isOpenChat,
    FieldValue? createdAt,
  }) async {
    DocumentReference roomReference;
    List<DocumentReference>? userDocumentReferences;

    /// 그룹 채팅방인지 여부는 자동으로 결정된다.
    bool isGroupChat;

    ///
    if (otherUids != null) {
      userDocumentReferences =
          otherUids.map((e) => db.collection('users').doc(e)).toList();
    }

    if (otherUserDocumentReference != null) {
      roomReference = getSingChatRoomReference(
        otherUserDocumentReference,
      );
      isGroupChat = false;
    } else {
      roomReference = rooms.doc();
      isGroupChat = true;
    }

    final info = createChatRoomData(
      id: roomReference.id,
      title: title,
      isGroupChat: isGroupChat,
      isOpenChat: isOpenChat,
      lastMessageSeenBy: FieldValue.arrayUnion([my.reference]),
      userDocumentReferences: userDocumentReferences ?? [my.reference],
      leaveProtocolMessage: true,
      urlClick: true,
      urlPreview: true,
    );

    // print('createRoom() info: $info');

    await roomReference.set(info);
    return roomReference;
  }

  /// 채팅방 문서 [id] 를 입력 받아, DB 로 부터 가져와, ChatRoomModel 로 리턴한다.
  ///
  /// 채팅방 정보가 존재하지 않으면 null 을 리턴한다.
  ///
  /// 주의, 나의 reference 가 userDocumentReferences 에 포함되어 있어야 한다. 그렇지 않으면, null 을
  /// 리턴한다.
  /// 이러한 이유로, 내가 채팅방에 들어가 있거나, open chat 인 경우에만 채팅방 정보를 가져올 수 있다.
  ///
  /// 채팅방 정보를 가져오는 방법은 다음과 같다.
  /// - 먼저 userDocumentReferences 에 나의 ref 가 포함되어 있는지 쿼리를 한다.
  ///   - 1:1 채팅이든 그룹 채팅이든 나의 ref 가 userDocumentReferences 에 들어가 있어야 한다.
  /// - 만약, userDocumentReferences 에 나의 ref 가 포함되어져 있지 않으면, 그리고 그룹 챗 ID 이면,
  ///   - isOpenChat 으로 검색을 한번 더 검색한다. 즉, open chat 의 경우 채팅방을 읽을 수 있는 것이다.
  ///
  Future<ChatRoomModel?> getRoom(String id) async {
    final QuerySnapshot querySnapshot = await rooms
        .where('userDocumentReferences', arrayContains: my.reference)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    if (querySnapshot.size != 0) {
      return ChatRoomModel.fromSnapshot(querySnapshot.docs.first);
    }

    final QuerySnapshot querySnapshot2 = await rooms
        .where('isOpenChat', isEqualTo: true)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot2.size != 0) {
      return ChatRoomModel.fromSnapshot(querySnapshot2.docs.first);
    }

    return null;
  }

  /// alias of getRoom()
  Future<ChatRoomModel?> getChatRoom(String id) => getRoom(id);

  createOneAndOneChatRoom({
    required DocumentReference otherUserDocumentReference,
  }) async {
    await createRoom(
      otherUserDocumentReference: otherUserDocumentReference,
      otherUids: [otherUserDocumentReference.id],
    );
  }

  /// 채팅 메세지 전송
  ///
  /// This method sends a chat message and updates the chat room.
  ///
  /// Note, that this must be the only method to send a chat message.
  ///
  /// if [otherUserDocumentReference] is set, thne it is a one-to-one chat.
  /// if [chatRoomDocumentReference] is set, then it is a group chat.
  ///
  /// To send message fast, it first send the chat message. Then, it updates
  /// the chat room and send push notifications.
  ///
  /// Note, that it will not send push notifications and update chat room
  /// if the chat message has a protocol.
  ///
  /// Note that, this method is asynchronous. It does not wait until the
  /// functions to be finished.
  ///
  /// [otherUserDocumentReference] 는 1:1 채팅방의 경우에만 설정한다.
  /// [chatRoomDocumentReference] 는 그룹 채팅방의 경우에만 설정한다.
  /// [text] 는 채팅 메시지. 파일/사진 업로드 할 때에는 null.
  /// [uploadUrl] 는 파일/사진 업로드 할 때에 URL 입력. 채팅 메시지를 전송 할 때에는 null.
  /// [protocol] 는 프로토콜. 채팅 메시지 할 때에는 null.
  /// [protocolTargetUserDocumentReference] 는 프로토콜의 대상이 되는 사용자의 reference.
  /// [replyDisplayName] 는 답장할 때, 답장할 메시지의 사용자 이름.
  /// [replyText] 는 답장할 때, 답장할 메시지의 내용.
  ///
  sendMessage({
    DocumentReference? otherUserDocumentReference,
    DocumentReference? chatRoomDocumentReference,
    String? text,
    String? uploadUrl,
    String? protocol,
    DocumentReference? protocolTargetUserDocumentReference,
    String? replyDisplayName,
    String? replyText,
  }) async {
    assert(
        otherUserDocumentReference != null || chatRoomDocumentReference != null,
        "User document reference or chat room document reference must be set.");
    if ((text == null || text.isEmpty) &&
        (uploadUrl == null || uploadUrl.isEmpty) &&
        (protocol == null || protocol.isEmpty)) {
      return;
    }

    /// Create a chat message
    final db = FirebaseFirestore.instance;
    final myUid = UserService.instance.uid;
    DocumentReference chatRoomRef;

    /// Note, chatRoomDocumentReference may always exists.
    bool isGroupChat = otherUserDocumentReference == null;

    if (isGroupChat) {
      chatRoomRef = chatRoomDocumentReference!;
    } else {
      chatRoomRef = db
          .collection('chat_rooms')
          .doc(([myUid, otherUserDocumentReference.id]..sort()).join('-'));
    }

    /// Send chat message asynchronously.
    ///
    final data = {
      'chatRoomDocumentReference': chatRoomRef,
      'userDocumentReference': UserService.instance.ref,
      'sentAt': FieldValue.serverTimestamp(),
      if (text != null) 'text': text,
      if (uploadUrl != null) 'uploadUrl': uploadUrl,
      if (uploadUrl != null) 'uploadUrlType': uploadUrlType(uploadUrl),
      if (protocol != null) 'protocol': protocol,
      if (protocolTargetUserDocumentReference != null)
        'protocolTargetUserDocumentReference':
            protocolTargetUserDocumentReference,
      if (replyDisplayName != null) 'replyDisplayName': replyDisplayName,
      if (replyText != null) 'replyText': replyText,
    };
    db.collection('chat_room_messages').add(data).then((ref) async {
      /// Update url preview
      final model = UrlPreviewModel();
      await model.load(text ?? '');

      if (model.hasData) {
        final data = {
          'previewUrl': model.firstLink!,
          if (model.title != null) 'previewTitle': model.title,
          if (model.description != null)
            'previewDescription': model.description,
          if (model.image != null) 'previewImageUrl': model.image,
        };
        await ref.set(data, SetOptions(merge: true));
      }
    });

    /// If the chat message has a protocol,
    /// don't update chat room and don't send push notifications.
    if (protocol != null) {
      return;
    }

    /// Update the chat room without waiting.
    ///
    ///
    final info = {
      'lastMessage': text ?? '',
      'lastMessageSentAt': FieldValue.serverTimestamp(),
      'lastMessageSentBy': UserService.instance.ref,
      'lastMessageSeenBy': [UserService.instance.ref],
      'lastMessageUploadUrl': uploadUrl ?? '',
      'noOfMessages': FieldValue.increment(1),
    };
    chatRoomRef.set(info, SetOptions(merge: true));

    /// Count chat message on every minutes
    UserService.instance.countChatMessage();

    /// Send push notifications -----------------------------------
    ///
    /// Title and text for the notification
    late final String title;
    if ((text == null || text.isEmpty) &&
        (uploadUrl != null && uploadUrl.isNotEmpty)) {
      text = 'Tap to see the photo.';
      title = '${my.displayName} sent a photo';
    } else {
      title = '${my.displayName} say ...';
    }

    final room = ChatRoomModel.fromSnapshot(await chatRoomRef.get());

    /// Remove unsubscribed users
    ///
    final userRefs = room.userDocumentReferences;
    if (room.unsubscribedUserDocumentReferences.isNotEmpty) {
      userRefs.removeWhere(
          (ref) => room.unsubscribedUserDocumentReferences.contains(ref));
    }

    await MessagingService.instance.send(
      notificationTitle: title,
      notificationText: text,
      notificationSound: 'default',
      notificationImageUrl: uploadUrl,
      userRefs: userRefs,
      initialPageName: 'ChatRoom',
      parameterData: {
        if (isGroupChat)
          'chatRoomDocumentReference': chatRoomRef
        else
          'otherUserDocumentReference': UserService.instance.ref,

        /// Send the chat room id. This is being used to detect if the user
        /// is already in the chat room.
        'chatRoomId': chatRoomRef.id,
      },
    );

    return;
  }

  /// Call this method after updating the chat room
  Future updateMessage({
    required DocumentReference chatRoomMessageDocumentReference,
  }) async {
    final snapshot = await chatRoomMessageDocumentReference.get();
    final message = ChatRoomMessageModel.fromSnapshot(snapshot);

    /// Update url preview
    final model = UrlPreviewModel();
    await model.load(message.text);

    Map<String, dynamic> data = {};
    if (model.hasData) {
      data = {
        'previewUrl': model.firstLink!,
        if (model.title != null) 'previewTitle': model.title,
        if (model.description != null) 'previewDescription': model.description,
        if (model.image != null) 'previewImageUrl': model.image,
      };
    } else {
      data = {
        'previewUrl': FieldValue.delete(),
        'previewTitle': FieldValue.delete(),
        'previewDescription': FieldValue.delete(),
        'previewImageUrl': FieldValue.delete(),
      };
    }
    await chatRoomMessageDocumentReference.update(data);
  }

  /// inviteUser
  ///
  /// Returns true if the user add invited successfully. Otherwise, returns false.
  Future<bool> inviteUser({
    required DocumentReference chatRoomDocumentReference,
    required DocumentReference userDocumentReference,
  }) async {
    final snapshot = await chatRoomDocumentReference.get();
    final room = ChatRoomModel.fromSnapshot(snapshot);

    /// If the user is already in the chat room, then return false.
    if (room.userDocumentReferences.contains(userDocumentReference)) {
      return false;
    }
    final chatRoomsUpdateData = {
      'userDocumentReferences': FieldValue.arrayUnion([userDocumentReference]),
    };

    final List<Future> futures = [
      chatRoomDocumentReference.update(chatRoomsUpdateData),
      sendMessage(
        chatRoomDocumentReference: chatRoomDocumentReference,
        protocol: 'invite',
        protocolTargetUserDocumentReference: userDocumentReference,
      )
    ];
    await Future.wait(futures);
    return true;
  }

  /// remove a user from the chat room
  ///
  /// This method removes a user from the chat room and sends a message to the chat room.
  Future removeUser({
    required DocumentReference chatRoomDocumentReference,
    required DocumentReference userDocumentReference,
  }) async {
    final data = {
      'userDocumentReferences': FieldValue.arrayRemove([userDocumentReference]),
    };
    final List<Future> futures = [
      chatRoomDocumentReference.update(data),
      sendMessage(
        chatRoomDocumentReference: chatRoomDocumentReference,
        protocol: 'remove',
        protocolTargetUserDocumentReference: userDocumentReference,
      )
    ];

    return Future.wait(futures);
  }

  /// leave a chat room
  ///
  /// This method removes the current user from the chat room and sends a message to the chat room.
  /// Note that, 'leave' message must be recorded first before leaving.
  Future leave({
    required DocumentReference chatRoomDocumentReference,
  }) async {
    await sendMessage(
      chatRoomDocumentReference: chatRoomDocumentReference,
      protocol: 'leave',
    );

    return chatRoomDocumentReference.update({
      'userDocumentReferences':
          FieldValue.arrayRemove([UserService.instance.ref]),
    });
  }

  /// Do things after chat room created
  ///
  /// This method must be called only after a sub-group-chat room is created.
  /// No need to call this method for single-chat or group-chat room.
  ///
  /// See readme.
  ///
  /// TODO merge it into chatRoomCreate. And let flutterflow call the chatRoomCrate directly.
  Future chatRoomAfterCreate({
    required DocumentReference chatRoomDocumentReference,
  }) async {
    final room =
        ChatRoomModel.fromSnapshot(await chatRoomDocumentReference.get());

    if (room.parentChatRoomDocumentReference != null) {
      final snapshot = await rooms
          .where('isOpenChat', isEqualTo: true)
          .where('parentChatRoomDocumentReference',
              isEqualTo: room.parentChatRoomDocumentReference)
          .get();
      final count = snapshot.docs.length;
      await room.parentChatRoomDocumentReference!.update({
        'subChatRoomCount': count,
        'isSubChatRoom': false,
      });

      await chatRoomDocumentReference.update({
        'isSubChatRoom': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      await chatRoomDocumentReference.update({
        'isSubChatRoom': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// 채팅방 reference 로 부터, 다른 사용자 reference 를 리턴.
  ///
  /// 1:1 채팅이면 항상 채팅방 reference 에 하이픈(-)이 있다.
  ///
  DocumentReference getOtherUserDocumentReferenceFromChatRoomReference(
      DocumentReference chatRoomDocumentReference) {
    final id = chatRoomDocumentReference.id;
    final myUid = UserService.instance.uid;
    final uids = id.split('-');
    final otherUid = uids.first == myUid ? uids.last : uids.first;
    return UserService.instance.doc(otherUid);
  }

  /// 그룹 챗이면 true 리턴
  bool isGroupChat(String chatRoomId) {
    return !isSingleChat(chatRoomId);
  }

  /// Single Chat (1:1 챗) 이면 true 리턴
  bool isSingleChat(String chatRoomId) {
    return chatRoomId.contains('-');
  }

  /// 채팅방 정보 문서 업데이트
  ///
  /// 채팅방 정보 문서가 존재하지 않으면 생성한다.
  ///
  /// 채팅방 ID 를 저장한다.
  Future upsert(
    DocumentReference chatRoomDocumentReference, {
    FieldValue? userDocumentReferences,
    FieldValue? lastMessageSeenBy,
    bool? isGroupChat,
    bool? isSubChatRoom,
  }) {
    return chatRoomDocumentReference.set(
      {
        if (userDocumentReferences != null)
          'userDocumentReferences': userDocumentReferences,
        if (lastMessageSeenBy != null) 'lastMessageSeenBy': lastMessageSeenBy,
        if (isGroupChat != null) 'isGroupChat': isGroupChat,
        if (isSubChatRoom != null) 'isSubChatRoom': isSubChatRoom,
        'id': chatRoomDocumentReference.id,
      },
      SetOptions(merge: true),
    );
  }

  /// 나 자신을 오픈 챗 방에 추가한다.
  Future enter({
    ChatRoomModel? room,
  }) async {
    /// 방 정보가 존재하고,
    if (room == null) {
      return;
    }

    /// 내가 방에 없고, 오픈 챗이면,
    if (room.userDocumentReferences.contains(my.reference) == false &&
        room.isOpenChat) {
      try {
        /// 나를 추가
        await upsert(
          room.reference,
          userDocumentReferences: FieldValue.arrayUnion([my.reference]),
        );
      } catch (e) {
        dog('에러 발생: 그룹 채팅방 사용자 추가 $e');
        rethrow;
      }
      try {
        /// 나를 추가 후, enter protocol 메시지를 보낸다.
        await ChatService.instance.sendMessage(
          chatRoomDocumentReference: room.reference,
          protocol: 'enter',
          protocolTargetUserDocumentReference: my.reference,
        );
      } catch (e) {
        dog('에러 발생: 그룹 채팅방 입장 메시지 보내기 $e');
        rethrow;
      }
    }
  }
}
