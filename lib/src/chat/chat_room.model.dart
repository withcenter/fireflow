import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  List<DocumentReference> userDocumentReferences;
  String lastMessage;
  Timestamp lastMessageSentAt;
  List<DocumentReference> lastMessageSeenBy;
  DocumentReference? lastMessageSentBy;
  String? title;
  DocumentReference? moderatorUserDocumentReference;
  List<DocumentReference> unsubscribedUserDocumentReferences;

  ChatRoomModel({
    required this.userDocumentReferences,
    required this.lastMessage,
    required this.lastMessageSentAt,
    required this.lastMessageSeenBy,
    required this.lastMessageSentBy,
    required this.title,
    required this.moderatorUserDocumentReference,
    required this.unsubscribedUserDocumentReferences,
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
      userDocumentReferences: json['userDocumentReferences'] ?? [],
      lastMessage: json['lastMessage'] ?? '',
      lastMessageSentAt: json['lastMessageSentAt'] ?? Timestamp.now(),
      lastMessageSeenBy: json['lastMessageSeenBy'] ?? [],
      lastMessageSentBy: json['lastMessageSentBy'],
      title: json['title'],
      moderatorUserDocumentReference: json['moderatorUserDocumentReference'],
      unsubscribedUserDocumentReferences:
          json['unsubscribedUserDocumentReferences'] ?? [],
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'ChatRoomModel{ userDocumentReferences: $userDocumentReferences, lastMessage: $lastMessage, lastMessageSentAt: $lastMessageSentAt, lastMessageSeenBy: $lastMessageSeenBy, lastMessageSentBy: $lastMessageSentBy, title: $title, moderatorUserDocumentReference: $moderatorUserDocumentReference, unsubscribedUserDocumentReferences: $unsubscribedUserDocumentReferences }';
  }
}
