import 'package:cloud_firestore/cloud_firestore.dart';

/// ChatRoomModel is a class that represents a document of /chat_rooms.
///
@Deprecated('ChatRoomModel is deprecated. Use BuiltValue instead.')
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
  bool isOpenChat;

  String reminder;
  String lastMessageUploadUrl;
  String backgroundColor;
  bool urlClick;
  bool urlPreview;
  DocumentReference? parentChatRoomDocumentReference;
  String id;

  bool isSubChatRoom;

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
    required this.isOpenChat,
    required this.reminder,
    required this.lastMessageUploadUrl,
    required this.backgroundColor,
    required this.urlClick,
    required this.urlPreview,
    required this.parentChatRoomDocumentReference,
    required this.isSubChatRoom,
    required this.id,
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
      isOpenChat: json['isOpenChat'] ?? false,
      reminder: json['reminder'] ?? '',
      lastMessageUploadUrl: json['lastMessageUploadUrl'] ?? '',
      backgroundColor: json['backgroundColor'] ?? '',
      urlClick: json['urlClick'] ?? false,
      urlPreview: json['urlPreview'] ?? false,
      parentChatRoomDocumentReference: json['parentChatRoomDocumentReference'],
      isSubChatRoom: json['isSubChatRoom'] ?? false,
      id: id ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'ChatRoomModel{ id: $id, userDocumentReferences: $userDocumentReferences, lastMessage: $lastMessage, lastMessageSentAt: $lastMessageSentAt, lastMessageSeenBy: $lastMessageSeenBy, lastMessageSentBy: $lastMessageSentBy, title: $title, moderatorUserDocumentReferences: $moderatorUserDocumentReferences, unsubscribedUserDocumentReferences: $unsubscribedUserDocumentReferences, isGroupChat: $isGroupChat, isOpenChat: $isOpenChat, reminder: $reminder, lastMessageUploadUrl: $lastMessageUploadUrl, backgroundColor: $backgroundColor, urlClick: $urlClick, urlPreview: $urlPreview, parentChatRoomDocumentReference: $parentChatRoomDocumentReference, isSubChatRoom: $isSubChatRoom }';
  }
}
