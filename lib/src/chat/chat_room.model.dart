import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// ChatRoomModel is a class that represents a document of /chat_rooms.
///
class ChatRoomModel {
  DocumentReference reference;
  String id;
  List<DocumentReference> userDocumentReferences;
  String lastMessage;
  DateTime lastMessageSentAt;
  List<DocumentReference> lastMessageSeenBy;
  DocumentReference? lastMessageSentBy;
  String title;
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

  bool isSubChatRoom;

  ChatRoomModel({
    required this.reference,
    required this.id,
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
  });

  factory ChatRoomModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ChatRoomModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      reference: snapshot.reference,
    );
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> json,
      {required DocumentReference reference}) {
    return ChatRoomModel(
      reference: reference,
      id: reference.id,
      userDocumentReferences:
          List<DocumentReference>.from(json['userDocumentReferences'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastMessageSentAt:
          ((json['lastMessageSentAt'] ?? Timestamp.now()) as Timestamp)
              .toDate(),
      lastMessageSeenBy: List<DocumentReference>.from(
        json['lastMessageSeenBy'] ?? <DocumentReference>[],
      ),
      lastMessageSentBy: json['lastMessageSentBy'],
      title: json['title'] ?? "",
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
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'ChatRoomModel{ id: $id, userDocumentReferences: $userDocumentReferences, lastMessage: $lastMessage, lastMessageSentAt: $lastMessageSentAt, lastMessageSeenBy: $lastMessageSeenBy, lastMessageSentBy: $lastMessageSentBy, title: $title, moderatorUserDocumentReferences: $moderatorUserDocumentReferences, unsubscribedUserDocumentReferences: $unsubscribedUserDocumentReferences, isGroupChat: $isGroupChat, isOpenChat: $isOpenChat, reminder: $reminder, lastMessageUploadUrl: $lastMessageUploadUrl, backgroundColor: $backgroundColor, urlClick: $urlClick, urlPreview: $urlPreview, parentChatRoomDocumentReference: $parentChatRoomDocumentReference, isSubChatRoom: $isSubChatRoom }';
  }

  Future upsert({
    FieldValue? userDocumentReferences,
    FieldValue? lastMessageSeenBy,
    bool? isGroupChat,
    bool? isSubChatRoom,
  }) {
    return ChatService.instance.upsert(
      reference,
      userDocumentReferences: userDocumentReferences,
      lastMessageSeenBy: lastMessageSeenBy,
      isGroupChat: isGroupChat,
      isSubChatRoom: isSubChatRoom,
    );
  }

  /// 채팅방에 가장 마지막으로 입장한 사용자 ref 를 리턴한다.
  /// 단, 마지막 입장한 사용자가, 마지막 채팅 사용자라면, 그 전 사용자를 리턴.
  ///
  /// 참고로, Firestore 의 LIST(array)는 입장한 순서대로 저장된다.
  DocumentReference get lastEnteredUser {
    /// 채팅방 입장한 사용자 목록
    final users = userDocumentReferences;

    /// 채팅방에 입장한 사용자가 없는 경우, 방장이 있으면 방장을 리턴한다.
    if (users.isEmpty) {
      if (moderatorUserDocumentReferences != null ||
          moderatorUserDocumentReferences!.isNotEmpty) {
        return moderatorUserDocumentReferences!.first;
      } else {
        /// 모순 에러. 방장도 없는데, 채팅방에 입장한 사용자도 없는 경우는 없다. 이 경우는 발생하지 말아야 한다.
        return my.reference;
      }
    } else if (users.length == 1) {
      return users.first;

      /// 마지막 입장한 사용자가, 마지막 채팅 사용자라면, 그 전 사용자를 리턴.
    } else if (lastMessageSentBy == users.last) {
      return users[users.length - 2];
    } else {
      /// 그 외에는 마지막 입장한 사용자를 리턴.
      return users.last;
    }
  }

  /// 마지막으로 채팅을 보낸 사용자의 ref 를 리턴한다.
  /// 단, 마지막 채팅 사용자가 없는 경우, 마지막 입장한 사용자를 리턴한다.
  DocumentReference get lastMessagedUser {
    return lastMessageSentBy ?? lastEnteredUser;
  }

  /// 내가 채팅방의 마지막 메시지를 읽었으면, true 아니면 false 를 리턴한다.
  bool get isRead {
    if (lastMessageSentBy == my.reference) {
      return true;
    } else {
      return lastMessageSeenBy.contains(my.reference);
    }
  }

  /// 내가 방에 입장했으면, true 아니면 false 를 리턴한다.
  bool get isMember {
    return userDocumentReferences.contains(my.reference);
  }
}

/// Chat room 문서를 생성하기 위한 Data Map 을 만드는 함수
Map<String, dynamic> createChatRoomData({
  required String id,
  required List<DocumentReference> userDocumentReferences,
  String? lastMessage,
  DateTime? lastMessageSentAt,
  FieldValue? lastMessageSeenBy,
  DocumentReference? lastMessageSentBy,
  String? title,
  List<DocumentReference>? moderatorUserDocumentReferences,
  List<DocumentReference>? unsubscribedUserDocumentReferences,
  bool? isGroupChat,
  bool? isOpenChat,
  String? reminder,
  String? lastMessageUploadUrl,
  String? backgroundColor,
  bool? urlClick,
  bool? urlPreview,
  bool? leaveProtocolMessage,
  DocumentReference? parentChatRoomDocumentReference,
  bool? isSubChatRoom,
}) {
  return {
    'id': id,
    'userDocumentReferences': userDocumentReferences,
    if (lastMessage != null) 'lastMessage': lastMessage,
    if (lastMessageSentAt != null) 'lastMessageSentAt': lastMessageSentAt,
    if (lastMessageSeenBy != null) 'lastMessageSeenBy': lastMessageSeenBy,
    if (lastMessageSentBy != null) 'lastMessageSentBy': lastMessageSentBy,
    if (title != null) 'title': title,
    if (moderatorUserDocumentReferences != null)
      'moderatorUserDocumentReferences': moderatorUserDocumentReferences,
    if (unsubscribedUserDocumentReferences != null)
      'unsubscribedUserDocumentReferences': unsubscribedUserDocumentReferences,
    if (isGroupChat != null) 'isGroupChat': isGroupChat,
    if (isOpenChat != null) 'isOpenChat': isOpenChat,
    if (reminder != null) 'reminder': reminder,
    if (lastMessageUploadUrl != null)
      'lastMessageUploadUrl': lastMessageUploadUrl,
    if (backgroundColor != null) 'backgroundColor': backgroundColor,
    if (urlClick != null) 'urlClick': urlClick,
    if (urlPreview != null) 'urlPreview': urlPreview,
    if (leaveProtocolMessage != null)
      'leaveProtocolMessage': leaveProtocolMessage,
    if (parentChatRoomDocumentReference != null)
      'parentChatRoomDocumentReference': parentChatRoomDocumentReference,
    if (isSubChatRoom != null) 'isSubChatRoom': isSubChatRoom,
  };
}
