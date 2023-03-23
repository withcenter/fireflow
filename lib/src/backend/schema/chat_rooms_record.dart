import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'chat_rooms_record.g.dart';

abstract class ChatRoomsRecord
    implements Built<ChatRoomsRecord, ChatRoomsRecordBuilder> {
  static Serializer<ChatRoomsRecord> get serializer =>
      _$chatRoomsRecordSerializer;

  BuiltList<DocumentReference>? get userDocumentReferences;

  String? get lastMessage;

  DateTime? get lastMessageSentAt;

  BuiltList<DocumentReference>? get lastMessageSeenBy;

  DocumentReference? get lastMessageSentBy;

  String? get title;

  BuiltList<DocumentReference>? get unsubscribedUserDocumentReferences;

  BuiltList<DocumentReference>? get moderatorUserDocumentReferences;

  bool? get isGroupChat;

  bool? get isOpenChat;

  String? get reminder;

  String? get lastMessageUploadUrl;

  String? get backgroundColor;

  bool? get urlClick;

  bool? get urlPreview;

  bool? get leaveProtocolMessage;

  DocumentReference? get parentChatRoomDocumentReference;

  int? get subChatRoomCount;

  int? get noOfMessages;

  bool? get isSubChatRoom;

  bool? get readOnly;

  DateTime? get createdAt;

  String? get introImagePath;

  String? get introText;

  BuiltList<DocumentReference>? get introSeenBy;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ChatRoomsRecordBuilder builder) => builder
    ..userDocumentReferences = ListBuilder()
    ..lastMessage = ''
    ..lastMessageSeenBy = ListBuilder()
    ..title = ''
    ..unsubscribedUserDocumentReferences = ListBuilder()
    ..moderatorUserDocumentReferences = ListBuilder()
    ..isGroupChat = false
    ..isOpenChat = false
    ..reminder = ''
    ..lastMessageUploadUrl = ''
    ..backgroundColor = ''
    ..urlClick = false
    ..urlPreview = false
    ..leaveProtocolMessage = false
    ..subChatRoomCount = 0
    ..noOfMessages = 0
    ..isSubChatRoom = false
    ..readOnly = false
    ..introImagePath = ''
    ..introText = ''
    ..introSeenBy = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_rooms');

  static Stream<ChatRoomsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ChatRoomsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ChatRoomsRecord._();
  factory ChatRoomsRecord([void Function(ChatRoomsRecordBuilder) updates]) =
      _$ChatRoomsRecord;

  static ChatRoomsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createChatRoomsRecordData({
  String? lastMessage,
  DateTime? lastMessageSentAt,
  DocumentReference? lastMessageSentBy,
  String? title,
  bool? isGroupChat,
  bool? isOpenChat,
  String? reminder,
  String? lastMessageUploadUrl,
  String? backgroundColor,
  bool? urlClick,
  bool? urlPreview,
  bool? leaveProtocolMessage,
  DocumentReference? parentChatRoomDocumentReference,
  int? subChatRoomCount,
  int? noOfMessages,
  bool? isSubChatRoom,
  bool? readOnly,
  DateTime? createdAt,
  String? introImagePath,
  String? introText,
}) {
  final firestoreData = serializers.toFirestore(
    ChatRoomsRecord.serializer,
    ChatRoomsRecord(
      (c) => c
        ..userDocumentReferences = null
        ..lastMessage = lastMessage
        ..lastMessageSentAt = lastMessageSentAt
        ..lastMessageSeenBy = null
        ..lastMessageSentBy = lastMessageSentBy
        ..title = title
        ..unsubscribedUserDocumentReferences = null
        ..moderatorUserDocumentReferences = null
        ..isGroupChat = isGroupChat
        ..isOpenChat = isOpenChat
        ..reminder = reminder
        ..lastMessageUploadUrl = lastMessageUploadUrl
        ..backgroundColor = backgroundColor
        ..urlClick = urlClick
        ..urlPreview = urlPreview
        ..leaveProtocolMessage = leaveProtocolMessage
        ..parentChatRoomDocumentReference = parentChatRoomDocumentReference
        ..subChatRoomCount = subChatRoomCount
        ..noOfMessages = noOfMessages
        ..isSubChatRoom = isSubChatRoom
        ..readOnly = readOnly
        ..createdAt = createdAt
        ..introImagePath = introImagePath
        ..introText = introText
        ..introSeenBy = null,
    ),
  );

  return firestoreData;
}
