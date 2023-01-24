import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

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

  /// Returns a chat room message document reference of the given id.
  DocumentReference message(String id) => messages.doc(id);

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
  sendMessage({
    DocumentReference? otherUserDocumentReference,
    DocumentReference? chatRoomDocumentReference,
    String? text,
    String? uploadUrl,
    String? protocol,
    DocumentReference? protocolTargetUserDocumentReference,
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
    bool isGroupChat = chatRoomDocumentReference != null;

    if (isGroupChat) {
      chatRoomRef = chatRoomDocumentReference;
    } else {
      chatRoomRef = db
          .collection('chat_rooms')
          .doc(([myUid, otherUserDocumentReference!.id]..sort()).join('-'));
    }

    /// Send chat message asynchronously.
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
    };
    db.collection('chat_room_messages').add(data);

    /// If the chat message has a protocol,
    /// don't update chat room and don't send push notifications.
    if (protocol != null) {
      return;
    }

    /// Update the chat room asynchronously.
    final info = {
      'lastMessage': text,
      'lastMessageSentAt': FieldValue.serverTimestamp(),
      'lastMessageSentBy': UserService.instance.ref,
      'lastMessageSeenBy': [UserService.instance.ref],
    };
    chatRoomRef.set(info, SetOptions(merge: true));

    /// Send push notifications
    ///
    /// Title and text for the notification
    late final String title;
    if ((text == null || text.isEmpty) &&
        (uploadUrl != null && uploadUrl.isNotEmpty)) {
      text = 'Tap to see the photo.';
      title = '${AppService.instance.user?.displayName} sent a photo';
    } else {
      title = '${AppService.instance.user?.displayName} say ...';
    }

    final room = ChatRoomModel.fromSnapshot(await chatRoomRef.get());

    /// Remove unsubscribed users
    ///g
    final userRefs = room.userDocumentReferences;
    if (room.unsubscribedUserDocumentReferences.isNotEmpty) {
      userRefs.removeWhere(
          (ref) => room.unsubscribedUserDocumentReferences.contains(ref));
    }

    /// Send push notifications
    ///

    MessagingService.instance.send(
      notificationTitle: title,
      notificationText: text,
      notificationSound: 'default',
      notificationImageUrl: uploadUrl,
      userRefs: userRefs,
      initialPageName: 'ChatRoom',
      parameterData: {
        if (isGroupChat)
          'chatRoomDocument': chatRoomRef.id
        else
          'otherUserPublicDataDocument': UserService.instance.publicRef.id,

        /// Send the chat room id. This is being used to detect if the user
        /// is already in the chat room.
        'chatRoomId': chatRoomRef.id,
      },
    );

    return;
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
}
