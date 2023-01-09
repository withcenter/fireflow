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

  /// Returns a chat room message document reference of the given id.
  DocumentReference message(String id) => messages.doc(id);

  /// Send a message
  ///
  /// This method sends a chat message and updates the chat room.
  ///
  /// This must be the only method to send a chat message.
  ///
  /// if [otherUserDocumentReference] is set, thne it is a one-to-one chat.
  /// if [chatRoomDocumentReference] is set, then it is a group chat.
  /// We needs [userDocumentReferences] if it is a group chat to avoid reading the chat room document for saving time.
  sendMessage({
    DocumentReference? otherUserDocumentReference,
    DocumentReference? chatRoomDocumentReference,
    String? text,
    String? uploadUrl,
    String? protocol,
    DocumentReference? protocolTargetUserDocumentReference,
    List<DocumentReference>? userDocumentReferences,
  }) {
    assert(
        otherUserDocumentReference != null || chatRoomDocumentReference != null,
        "User document reference or chat room document reference must be set.");
    if ((text == null || text.isEmpty) &&
        (uploadUrl == null || uploadUrl.isEmpty) &&
        (protocol == null || protocol.isEmpty)) {
      return;
    }

    List<Future> futures = [];

    /// Create a chat message
    final db = FirebaseFirestore.instance;
    final myUid = UserService.instance.uid;
    DocumentReference ref;
    bool isGroupChat = chatRoomDocumentReference != null;

    if (isGroupChat) {
      ref = chatRoomDocumentReference;
    } else {
      ref = db
          .collection('chat_rooms')
          .doc(([myUid, otherUserDocumentReference!.id]..sort()).join('-'));
    }

    /// Send chat message
    final data = {
      'chatRoomDocumentReference': ref,
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

    futures.add(db.collection('chat_room_messages').add(data));

    /// Update the chat room
    final info = {
      'lastMessage': text,
      'lastMessageSentAt': FieldValue.serverTimestamp(),
      'lastMessageSentBy': UserService.instance.ref,
      'lastMessageSeenBy': [UserService.instance.ref],
    };
    futures.add(ref.set(info, SetOptions(merge: true)));

    /// Send push notifications

    futures.add(
      MessagingService.instance.send(
        notificationTitle: '${AppService.instance.user?.displayName} say ...',
        notificationText: text,
        notificationSound: 'default',
        userRefs: userDocumentReferences ?? [otherUserDocumentReference!],
        initialPageName: 'ChatRoom',
        parameterData: {
          'chatRoomDocument': chatRoomDocumentReference,
          'otherUserPublicDataDocument': otherUserDocumentReference,
        },
      ),
    );

    return Future.wait(futures);
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
