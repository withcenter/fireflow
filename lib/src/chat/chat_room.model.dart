import 'package:cloud_firestore/cloud_firestore.dart';

/// ChatRoomModel is a class that represents a document of /chat_rooms.
///
class ChatRoomModel {
  List<DocumentReference> userDocumentReferences;
  String lastMessage;
  Timestamp lastMessageSentAt;
  List<DocumentReference> lastMessageSeenBy;
  DocumentReference? lastMessageSentBy;
  String? title;
  List<DocumentReference>? moderatorUserDocumentReferences;
  List<DocumentReference> unsubscribedUserDocumentReferences;
  bool isGroupChat;

  ChatRoomModel({
    required this.userDocumentReferences,
    required this.lastMessage,
    required this.lastMessageSentAt,
    required this.lastMessageSeenBy,
    required this.lastMessageSentBy,
    required this.title,
    required this.moderatorUserDocumentReferences,
    required this.unsubscribedUserDocumentReferences,
    required this.isGroupChat,
  });

  factory ChatRoomModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ChatRoomModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  factory ChatRoomModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return ChatRoomModel(
      userDocumentReferences:
          List<DocumentReference>.from(json['userDocumentReferences'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastMessageSentAt: json['lastMessageSentAt'] ?? Timestamp.now(),
      lastMessageSeenBy: List<DocumentReference>.from(
        json['lastMessageSeenBy'] ?? <DocumentReference>[],
      ),
      lastMessageSentBy: json['lastMessageSentBy'],
      title: json['title'],
      moderatorUserDocumentReferences: List<DocumentReference>.from(
          json['moderatorUserDocumentReferences'] ?? []),
      unsubscribedUserDocumentReferences: List<DocumentReference>.from(
          json['unsubscribedUserDocumentReferences'] ?? []),
      isGroupChat: json['isGroupChat'] ?? false,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'ChatRoomModel{ userDocumentReferences: $userDocumentReferences, lastMessage: $lastMessage, lastMessageSentAt: $lastMessageSentAt, lastMessageSeenBy: $lastMessageSeenBy, lastMessageSentBy: $lastMessageSentBy, title: $title, moderatorUserDocumentReferences: $moderatorUserDocumentReferences, unsubscribedUserDocumentReferences: $unsubscribedUserDocumentReferences, isGroupChat: $isGroupChat }';
  }
}
