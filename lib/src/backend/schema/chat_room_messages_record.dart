import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'chat_room_messages_record.g.dart';

abstract class ChatRoomMessagesRecord
    implements Built<ChatRoomMessagesRecord, ChatRoomMessagesRecordBuilder> {
  static Serializer<ChatRoomMessagesRecord> get serializer =>
      _$chatRoomMessagesRecordSerializer;

  DocumentReference? get userDocumentReference;

  DocumentReference? get chatRoomDocumentReference;

  String? get text;

  DateTime? get sentAt;

  String? get uploadUrl;

  String? get uploadUrlType;

  String? get protocol;

  DocumentReference? get protocolTargetUserDocumentReference;

  String? get previewUrl;

  String? get previewTitle;

  String? get previewDescription;

  String? get previewImageUrl;

  String? get replyDisplayName;

  String? get replyText;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ChatRoomMessagesRecordBuilder builder) =>
      builder
        ..text = ''
        ..uploadUrl = ''
        ..uploadUrlType = ''
        ..protocol = ''
        ..previewUrl = ''
        ..previewTitle = ''
        ..previewDescription = ''
        ..previewImageUrl = ''
        ..replyDisplayName = ''
        ..replyText = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_room_messages');

  static Stream<ChatRoomMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ChatRoomMessagesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ChatRoomMessagesRecord._();
  factory ChatRoomMessagesRecord(
          [void Function(ChatRoomMessagesRecordBuilder) updates]) =
      _$ChatRoomMessagesRecord;

  static ChatRoomMessagesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createChatRoomMessagesRecordData({
  DocumentReference? userDocumentReference,
  DocumentReference? chatRoomDocumentReference,
  String? text,
  DateTime? sentAt,
  String? uploadUrl,
  String? uploadUrlType,
  String? protocol,
  DocumentReference? protocolTargetUserDocumentReference,
  String? previewUrl,
  String? previewTitle,
  String? previewDescription,
  String? previewImageUrl,
  String? replyDisplayName,
  String? replyText,
}) {
  final firestoreData = serializers.toFirestore(
    ChatRoomMessagesRecord.serializer,
    ChatRoomMessagesRecord(
      (c) => c
        ..userDocumentReference = userDocumentReference
        ..chatRoomDocumentReference = chatRoomDocumentReference
        ..text = text
        ..sentAt = sentAt
        ..uploadUrl = uploadUrl
        ..uploadUrlType = uploadUrlType
        ..protocol = protocol
        ..protocolTargetUserDocumentReference =
            protocolTargetUserDocumentReference
        ..previewUrl = previewUrl
        ..previewTitle = previewTitle
        ..previewDescription = previewDescription
        ..previewImageUrl = previewImageUrl
        ..replyDisplayName = replyDisplayName
        ..replyText = replyText,
    ),
  );

  return firestoreData;
}
