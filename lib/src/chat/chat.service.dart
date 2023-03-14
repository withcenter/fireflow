import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutterflow_widgets/flutterflow_widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

  Query get myRooms => rooms.where('userDocumentReferences', arrayContains: UserService.instance.ref);

  /// Returns a chat room message document reference of the given id.
  DocumentReference message(String id) => messages.doc(id);

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

  /// Creates a chat room.
  ///
  /// [id] is the chat room id.
  createChatRoom({
    required String id,
    List<String>? otherUids,
  }) async {
    List<DocumentReference>? users;
    late bool isGroupChat;
    if (otherUids != null) {
      users = otherUids.map((e) => db.collection('users').doc(e)).toList();
    }

    if (id.contains('-')) {
      isGroupChat = false;
    } else {
      isGroupChat = true;
    }

    await rooms.doc(id).set({
      'isGroupChat': isGroupChat,
      'lastMessageSeenBy': FieldValue.arrayUnion([
        UserService.instance.ref,
      ]),
      'userDocumentReferences': users ?? [UserService.instance.ref],
      'leaveProtocolMessage': true,
      'urlClick': true,
      'urlPreview': true,
    });
  }

  createOneAndOneChatRoom({
    required String otherUserUid,
  }) async {
    final otherUserDocumentReference = db.collection('users').doc(otherUserUid);
    await createChatRoom(
      id: getOneAndOneChatRoomDocumentReference(otherUserUid).id,
      otherUids: [otherUserDocumentReference.id],
    );
  }

  /// Send a message
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
    assert(otherUserDocumentReference != null || chatRoomDocumentReference != null, "User document reference or chat room document reference must be set.");
    if ((text == null || text.isEmpty) && (uploadUrl == null || uploadUrl.isEmpty) && (protocol == null || protocol.isEmpty)) {
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
      chatRoomRef = db.collection('chat_rooms').doc(([myUid, otherUserDocumentReference.id]..sort()).join('-'));
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
      if (protocolTargetUserDocumentReference != null) 'protocolTargetUserDocumentReference': protocolTargetUserDocumentReference,
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
          if (model.description != null) 'previewDescription': model.description,
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
    if ((text == null || text.isEmpty) && (uploadUrl != null && uploadUrl.isNotEmpty)) {
      text = 'Tap to see the photo.';
      title = '${AppService.instance.my.displayName} sent a photo';
    } else {
      title = '${AppService.instance.my.displayName} say ...';
    }

    final room = ChatRoomModel.fromSnapshot(await chatRoomRef.get());

    /// Remove unsubscribed users
    ///
    final userRefs = room.userDocumentReferences;
    if (room.unsubscribedUserDocumentReferences.isNotEmpty) {
      userRefs.removeWhere((ref) => room.unsubscribedUserDocumentReferences.contains(ref));
    }

    MessagingService.instance.send(
      notificationTitle: title,
      notificationText: text,
      notificationSound: 'default',
      notificationImageUrl: uploadUrl,
      userRefs: userRefs,
      initialPageName: 'ChatRoom',
      parameterData: {
        if (isGroupChat) 'chatRoomDocumentReference': chatRoomRef else 'otherUserDocumentReference': UserService.instance.publicRef,

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
      'userDocumentReferences': FieldValue.arrayRemove([UserService.instance.ref]),
    });
  }

  /// Do things after chat room created
  ///
  /// This method must be called only after a sub-group-chat room is created.
  /// No need to call this method for single-chat or group-chat room.
  ///
  /// See readme.
  Future chatRoomAfterCreate({
    required DocumentReference chatRoomDocumentReference,
  }) async {
    final room = ChatRoomModel.fromSnapshot(await chatRoomDocumentReference.get());

    if (room.parentChatRoomDocumentReference != null) {
      final snapshot =
          await rooms.where('isOpenChat', isEqualTo: true).where('parentChatRoomDocumentReference', isEqualTo: room.parentChatRoomDocumentReference).get();
      final count = snapshot.docs.length;
      await room.parentChatRoomDocumentReference!.update({
        'subChatRoomCount': count,
        'isSubChatRoom': false,
      });

      await chatRoomDocumentReference.update({
        'isSubChatRoom': true,
      });
    } else {
      await chatRoomDocumentReference.update({
        'isSubChatRoom': false,
      });
    }
  }

  /// Get the other document reference from the one and one chat document reference
  ///
  DocumentReference getOtherUserDocumentReferenceFromChatRoomReference(DocumentReference chatRoomDocumentReference) {
    final id = chatRoomDocumentReference.id;
    final myUid = UserService.instance.uid;
    final uids = id.split('-');
    final otherUid = uids.first == myUid ? uids.last : uids.first;
    return UserService.instance.doc(otherUid);
  }
}
