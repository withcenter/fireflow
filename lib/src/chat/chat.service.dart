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
  sendMessage({
    required DocumentReference? otherUserPublicDataDocumentReference,
    required DocumentReference? chatRoomDocumentReference,
    required String? text,
    required String? uploadUrl,
  }) {
    dog("ChatService.messageSubmit() called.");

    if ((text == null || text.isEmpty) &&
        (uploadUrl == null || uploadUrl.isEmpty)) {
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
      ref = db.collection('chat_rooms').doc(([
            myUid,
            otherUserPublicDataDocumentReference!.id
          ]..sort())
              .join('-'));
    }

    final data = {
      'chatRoomDocumentReference': ref,
      'userDocumentReference': UserService.instance.ref,
      'sentAt': FieldValue.serverTimestamp(),
      if (text != null) 'text': text,
      if (uploadUrl != null) 'uploadUrl': uploadUrl,
      if (uploadUrl != null) 'uploadUrlType': uploadUrlType(uploadUrl),
    };

    futures.add(db.collection('chat_room_messages').add(data));

    /// Update the chat room
    final info = {
      'lastMessage': text,
      'lastMessageSentAt': FieldValue.serverTimestamp(),
      'lastMessageSentBy': UserService.instance.ref,
      'lastMessageSeenBy': [UserService.instance.ref],
    };
    futures.add(
      ref.set(info, SetOptions(merge: true)),
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
    if (room.userDocumentReferences.contains(userDocumentReference)) {
      return false;
    }
    final chatRoomsUpdateData = {
      'userDocumentReferences': FieldValue.arrayUnion([userDocumentReference]),
    };
    await chatRoomDocumentReference.update(chatRoomsUpdateData);
    return true;
  }
}
