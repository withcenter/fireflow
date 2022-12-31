import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// ChatService
///
/// ChatService is a singleton class that provides the chat service.
///
class ChatService {
  static ChatService get instance => _instance ?? (_instance = ChatService());
  static ChatService? _instance;

  /// Send a message
  ///
  /// This must be the only message to send a chat message.
  sendMessage({
    required DocumentReference? otherUserPublicDataDocumentReference,
    required DocumentReference? chatRoomDocumentReference,
    required String? text,
    required String? imagePath,
  }) {
    dog("ChatService.messageSubmit() called.");

    if ((text == null || text.isEmpty) &&
        (imagePath == null || imagePath.isEmpty)) {
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
      if (imagePath != null) 'photoUrl': imagePath,
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
}
