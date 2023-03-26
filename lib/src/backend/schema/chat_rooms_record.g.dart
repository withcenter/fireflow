// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rooms_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatRoomsRecord> _$chatRoomsRecordSerializer =
    new _$ChatRoomsRecordSerializer();

class _$ChatRoomsRecordSerializer
    implements StructuredSerializer<ChatRoomsRecord> {
  @override
  final Iterable<Type> types = const [ChatRoomsRecord, _$ChatRoomsRecord];
  @override
  final String wireName = 'ChatRoomsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatRoomsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userDocumentReferences;
    if (value != null) {
      result
        ..add('userDocumentReferences')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.lastMessage;
    if (value != null) {
      result
        ..add('lastMessage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastMessageSentAt;
    if (value != null) {
      result
        ..add('lastMessageSentAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.lastMessageSeenBy;
    if (value != null) {
      result
        ..add('lastMessageSeenBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.lastMessageSentBy;
    if (value != null) {
      result
        ..add('lastMessageSentBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.unsubscribedUserDocumentReferences;
    if (value != null) {
      result
        ..add('unsubscribedUserDocumentReferences')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.moderatorUserDocumentReferences;
    if (value != null) {
      result
        ..add('moderatorUserDocumentReferences')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.isGroupChat;
    if (value != null) {
      result
        ..add('isGroupChat')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isOpenChat;
    if (value != null) {
      result
        ..add('isOpenChat')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.reminder;
    if (value != null) {
      result
        ..add('reminder')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastMessageUploadUrl;
    if (value != null) {
      result
        ..add('lastMessageUploadUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.backgroundColor;
    if (value != null) {
      result
        ..add('backgroundColor')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.urlClick;
    if (value != null) {
      result
        ..add('urlClick')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.urlPreview;
    if (value != null) {
      result
        ..add('urlPreview')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.leaveProtocolMessage;
    if (value != null) {
      result
        ..add('leaveProtocolMessage')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.parentChatRoomDocumentReference;
    if (value != null) {
      result
        ..add('parentChatRoomDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.subChatRoomCount;
    if (value != null) {
      result
        ..add('subChatRoomCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.noOfMessages;
    if (value != null) {
      result
        ..add('noOfMessages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isSubChatRoom;
    if (value != null) {
      result
        ..add('isSubChatRoom')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.readOnly;
    if (value != null) {
      result
        ..add('readOnly')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.introImagePath;
    if (value != null) {
      result
        ..add('introImagePath')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.introText;
    if (value != null) {
      result
        ..add('introText')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.introSeenBy;
    if (value != null) {
      result
        ..add('introSeenBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ChatRoomsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatRoomsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userDocumentReferences':
          result.userDocumentReferences.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'lastMessage':
          result.lastMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lastMessageSentAt':
          result.lastMessageSentAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'lastMessageSeenBy':
          result.lastMessageSeenBy.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'lastMessageSentBy':
          result.lastMessageSentBy = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'unsubscribedUserDocumentReferences':
          result.unsubscribedUserDocumentReferences
              .replace(serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(DocumentReference,
                        const [const FullType.nullable(Object)])
                  ]))! as BuiltList<Object?>);
          break;
        case 'moderatorUserDocumentReferences':
          result.moderatorUserDocumentReferences
              .replace(serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(DocumentReference,
                        const [const FullType.nullable(Object)])
                  ]))! as BuiltList<Object?>);
          break;
        case 'isGroupChat':
          result.isGroupChat = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isOpenChat':
          result.isOpenChat = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'reminder':
          result.reminder = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lastMessageUploadUrl':
          result.lastMessageUploadUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'backgroundColor':
          result.backgroundColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'urlClick':
          result.urlClick = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'urlPreview':
          result.urlPreview = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'leaveProtocolMessage':
          result.leaveProtocolMessage = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'parentChatRoomDocumentReference':
          result.parentChatRoomDocumentReference = serializers.deserialize(
              value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'subChatRoomCount':
          result.subChatRoomCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'noOfMessages':
          result.noOfMessages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'isSubChatRoom':
          result.isSubChatRoom = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'readOnly':
          result.readOnly = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'introImagePath':
          result.introImagePath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'introText':
          result.introText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'introSeenBy':
          result.introSeenBy.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatRoomsRecord extends ChatRoomsRecord {
  @override
  final BuiltList<DocumentReference<Object?>>? userDocumentReferences;
  @override
  final String? lastMessage;
  @override
  final DateTime? lastMessageSentAt;
  @override
  final BuiltList<DocumentReference<Object?>>? lastMessageSeenBy;
  @override
  final DocumentReference<Object?>? lastMessageSentBy;
  @override
  final String? title;
  @override
  final BuiltList<DocumentReference<Object?>>?
      unsubscribedUserDocumentReferences;
  @override
  final BuiltList<DocumentReference<Object?>>? moderatorUserDocumentReferences;
  @override
  final bool? isGroupChat;
  @override
  final bool? isOpenChat;
  @override
  final String? reminder;
  @override
  final String? lastMessageUploadUrl;
  @override
  final String? backgroundColor;
  @override
  final bool? urlClick;
  @override
  final bool? urlPreview;
  @override
  final bool? leaveProtocolMessage;
  @override
  final DocumentReference<Object?>? parentChatRoomDocumentReference;
  @override
  final int? subChatRoomCount;
  @override
  final int? noOfMessages;
  @override
  final bool? isSubChatRoom;
  @override
  final bool? readOnly;
  @override
  final DateTime? createdAt;
  @override
  final String? introImagePath;
  @override
  final String? introText;
  @override
  final BuiltList<DocumentReference<Object?>>? introSeenBy;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ChatRoomsRecord([void Function(ChatRoomsRecordBuilder)? updates]) =>
      (new ChatRoomsRecordBuilder()..update(updates))._build();

  _$ChatRoomsRecord._(
      {this.userDocumentReferences,
      this.lastMessage,
      this.lastMessageSentAt,
      this.lastMessageSeenBy,
      this.lastMessageSentBy,
      this.title,
      this.unsubscribedUserDocumentReferences,
      this.moderatorUserDocumentReferences,
      this.isGroupChat,
      this.isOpenChat,
      this.reminder,
      this.lastMessageUploadUrl,
      this.backgroundColor,
      this.urlClick,
      this.urlPreview,
      this.leaveProtocolMessage,
      this.parentChatRoomDocumentReference,
      this.subChatRoomCount,
      this.noOfMessages,
      this.isSubChatRoom,
      this.readOnly,
      this.createdAt,
      this.introImagePath,
      this.introText,
      this.introSeenBy,
      this.ffRef})
      : super._();

  @override
  ChatRoomsRecord rebuild(void Function(ChatRoomsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRoomsRecordBuilder toBuilder() =>
      new ChatRoomsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRoomsRecord &&
        userDocumentReferences == other.userDocumentReferences &&
        lastMessage == other.lastMessage &&
        lastMessageSentAt == other.lastMessageSentAt &&
        lastMessageSeenBy == other.lastMessageSeenBy &&
        lastMessageSentBy == other.lastMessageSentBy &&
        title == other.title &&
        unsubscribedUserDocumentReferences ==
            other.unsubscribedUserDocumentReferences &&
        moderatorUserDocumentReferences ==
            other.moderatorUserDocumentReferences &&
        isGroupChat == other.isGroupChat &&
        isOpenChat == other.isOpenChat &&
        reminder == other.reminder &&
        lastMessageUploadUrl == other.lastMessageUploadUrl &&
        backgroundColor == other.backgroundColor &&
        urlClick == other.urlClick &&
        urlPreview == other.urlPreview &&
        leaveProtocolMessage == other.leaveProtocolMessage &&
        parentChatRoomDocumentReference ==
            other.parentChatRoomDocumentReference &&
        subChatRoomCount == other.subChatRoomCount &&
        noOfMessages == other.noOfMessages &&
        isSubChatRoom == other.isSubChatRoom &&
        readOnly == other.readOnly &&
        createdAt == other.createdAt &&
        introImagePath == other.introImagePath &&
        introText == other.introText &&
        introSeenBy == other.introSeenBy &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userDocumentReferences.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, lastMessageSentAt.hashCode);
    _$hash = $jc(_$hash, lastMessageSeenBy.hashCode);
    _$hash = $jc(_$hash, lastMessageSentBy.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, unsubscribedUserDocumentReferences.hashCode);
    _$hash = $jc(_$hash, moderatorUserDocumentReferences.hashCode);
    _$hash = $jc(_$hash, isGroupChat.hashCode);
    _$hash = $jc(_$hash, isOpenChat.hashCode);
    _$hash = $jc(_$hash, reminder.hashCode);
    _$hash = $jc(_$hash, lastMessageUploadUrl.hashCode);
    _$hash = $jc(_$hash, backgroundColor.hashCode);
    _$hash = $jc(_$hash, urlClick.hashCode);
    _$hash = $jc(_$hash, urlPreview.hashCode);
    _$hash = $jc(_$hash, leaveProtocolMessage.hashCode);
    _$hash = $jc(_$hash, parentChatRoomDocumentReference.hashCode);
    _$hash = $jc(_$hash, subChatRoomCount.hashCode);
    _$hash = $jc(_$hash, noOfMessages.hashCode);
    _$hash = $jc(_$hash, isSubChatRoom.hashCode);
    _$hash = $jc(_$hash, readOnly.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, introImagePath.hashCode);
    _$hash = $jc(_$hash, introText.hashCode);
    _$hash = $jc(_$hash, introSeenBy.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRoomsRecord')
          ..add('userDocumentReferences', userDocumentReferences)
          ..add('lastMessage', lastMessage)
          ..add('lastMessageSentAt', lastMessageSentAt)
          ..add('lastMessageSeenBy', lastMessageSeenBy)
          ..add('lastMessageSentBy', lastMessageSentBy)
          ..add('title', title)
          ..add('unsubscribedUserDocumentReferences',
              unsubscribedUserDocumentReferences)
          ..add('moderatorUserDocumentReferences',
              moderatorUserDocumentReferences)
          ..add('isGroupChat', isGroupChat)
          ..add('isOpenChat', isOpenChat)
          ..add('reminder', reminder)
          ..add('lastMessageUploadUrl', lastMessageUploadUrl)
          ..add('backgroundColor', backgroundColor)
          ..add('urlClick', urlClick)
          ..add('urlPreview', urlPreview)
          ..add('leaveProtocolMessage', leaveProtocolMessage)
          ..add('parentChatRoomDocumentReference',
              parentChatRoomDocumentReference)
          ..add('subChatRoomCount', subChatRoomCount)
          ..add('noOfMessages', noOfMessages)
          ..add('isSubChatRoom', isSubChatRoom)
          ..add('readOnly', readOnly)
          ..add('createdAt', createdAt)
          ..add('introImagePath', introImagePath)
          ..add('introText', introText)
          ..add('introSeenBy', introSeenBy)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ChatRoomsRecordBuilder
    implements Builder<ChatRoomsRecord, ChatRoomsRecordBuilder> {
  _$ChatRoomsRecord? _$v;

  ListBuilder<DocumentReference<Object?>>? _userDocumentReferences;
  ListBuilder<DocumentReference<Object?>> get userDocumentReferences =>
      _$this._userDocumentReferences ??=
          new ListBuilder<DocumentReference<Object?>>();
  set userDocumentReferences(
          ListBuilder<DocumentReference<Object?>>? userDocumentReferences) =>
      _$this._userDocumentReferences = userDocumentReferences;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  DateTime? _lastMessageSentAt;
  DateTime? get lastMessageSentAt => _$this._lastMessageSentAt;
  set lastMessageSentAt(DateTime? lastMessageSentAt) =>
      _$this._lastMessageSentAt = lastMessageSentAt;

  ListBuilder<DocumentReference<Object?>>? _lastMessageSeenBy;
  ListBuilder<DocumentReference<Object?>> get lastMessageSeenBy =>
      _$this._lastMessageSeenBy ??=
          new ListBuilder<DocumentReference<Object?>>();
  set lastMessageSeenBy(
          ListBuilder<DocumentReference<Object?>>? lastMessageSeenBy) =>
      _$this._lastMessageSeenBy = lastMessageSeenBy;

  DocumentReference<Object?>? _lastMessageSentBy;
  DocumentReference<Object?>? get lastMessageSentBy =>
      _$this._lastMessageSentBy;
  set lastMessageSentBy(DocumentReference<Object?>? lastMessageSentBy) =>
      _$this._lastMessageSentBy = lastMessageSentBy;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<DocumentReference<Object?>>? _unsubscribedUserDocumentReferences;
  ListBuilder<DocumentReference<Object?>>
      get unsubscribedUserDocumentReferences =>
          _$this._unsubscribedUserDocumentReferences ??=
              new ListBuilder<DocumentReference<Object?>>();
  set unsubscribedUserDocumentReferences(
          ListBuilder<DocumentReference<Object?>>?
              unsubscribedUserDocumentReferences) =>
      _$this._unsubscribedUserDocumentReferences =
          unsubscribedUserDocumentReferences;

  ListBuilder<DocumentReference<Object?>>? _moderatorUserDocumentReferences;
  ListBuilder<DocumentReference<Object?>> get moderatorUserDocumentReferences =>
      _$this._moderatorUserDocumentReferences ??=
          new ListBuilder<DocumentReference<Object?>>();
  set moderatorUserDocumentReferences(
          ListBuilder<DocumentReference<Object?>>?
              moderatorUserDocumentReferences) =>
      _$this._moderatorUserDocumentReferences = moderatorUserDocumentReferences;

  bool? _isGroupChat;
  bool? get isGroupChat => _$this._isGroupChat;
  set isGroupChat(bool? isGroupChat) => _$this._isGroupChat = isGroupChat;

  bool? _isOpenChat;
  bool? get isOpenChat => _$this._isOpenChat;
  set isOpenChat(bool? isOpenChat) => _$this._isOpenChat = isOpenChat;

  String? _reminder;
  String? get reminder => _$this._reminder;
  set reminder(String? reminder) => _$this._reminder = reminder;

  String? _lastMessageUploadUrl;
  String? get lastMessageUploadUrl => _$this._lastMessageUploadUrl;
  set lastMessageUploadUrl(String? lastMessageUploadUrl) =>
      _$this._lastMessageUploadUrl = lastMessageUploadUrl;

  String? _backgroundColor;
  String? get backgroundColor => _$this._backgroundColor;
  set backgroundColor(String? backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  bool? _urlClick;
  bool? get urlClick => _$this._urlClick;
  set urlClick(bool? urlClick) => _$this._urlClick = urlClick;

  bool? _urlPreview;
  bool? get urlPreview => _$this._urlPreview;
  set urlPreview(bool? urlPreview) => _$this._urlPreview = urlPreview;

  bool? _leaveProtocolMessage;
  bool? get leaveProtocolMessage => _$this._leaveProtocolMessage;
  set leaveProtocolMessage(bool? leaveProtocolMessage) =>
      _$this._leaveProtocolMessage = leaveProtocolMessage;

  DocumentReference<Object?>? _parentChatRoomDocumentReference;
  DocumentReference<Object?>? get parentChatRoomDocumentReference =>
      _$this._parentChatRoomDocumentReference;
  set parentChatRoomDocumentReference(
          DocumentReference<Object?>? parentChatRoomDocumentReference) =>
      _$this._parentChatRoomDocumentReference = parentChatRoomDocumentReference;

  int? _subChatRoomCount;
  int? get subChatRoomCount => _$this._subChatRoomCount;
  set subChatRoomCount(int? subChatRoomCount) =>
      _$this._subChatRoomCount = subChatRoomCount;

  int? _noOfMessages;
  int? get noOfMessages => _$this._noOfMessages;
  set noOfMessages(int? noOfMessages) => _$this._noOfMessages = noOfMessages;

  bool? _isSubChatRoom;
  bool? get isSubChatRoom => _$this._isSubChatRoom;
  set isSubChatRoom(bool? isSubChatRoom) =>
      _$this._isSubChatRoom = isSubChatRoom;

  bool? _readOnly;
  bool? get readOnly => _$this._readOnly;
  set readOnly(bool? readOnly) => _$this._readOnly = readOnly;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _introImagePath;
  String? get introImagePath => _$this._introImagePath;
  set introImagePath(String? introImagePath) =>
      _$this._introImagePath = introImagePath;

  String? _introText;
  String? get introText => _$this._introText;
  set introText(String? introText) => _$this._introText = introText;

  ListBuilder<DocumentReference<Object?>>? _introSeenBy;
  ListBuilder<DocumentReference<Object?>> get introSeenBy =>
      _$this._introSeenBy ??= new ListBuilder<DocumentReference<Object?>>();
  set introSeenBy(ListBuilder<DocumentReference<Object?>>? introSeenBy) =>
      _$this._introSeenBy = introSeenBy;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ChatRoomsRecordBuilder() {
    ChatRoomsRecord._initializeBuilder(this);
  }

  ChatRoomsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userDocumentReferences = $v.userDocumentReferences?.toBuilder();
      _lastMessage = $v.lastMessage;
      _lastMessageSentAt = $v.lastMessageSentAt;
      _lastMessageSeenBy = $v.lastMessageSeenBy?.toBuilder();
      _lastMessageSentBy = $v.lastMessageSentBy;
      _title = $v.title;
      _unsubscribedUserDocumentReferences =
          $v.unsubscribedUserDocumentReferences?.toBuilder();
      _moderatorUserDocumentReferences =
          $v.moderatorUserDocumentReferences?.toBuilder();
      _isGroupChat = $v.isGroupChat;
      _isOpenChat = $v.isOpenChat;
      _reminder = $v.reminder;
      _lastMessageUploadUrl = $v.lastMessageUploadUrl;
      _backgroundColor = $v.backgroundColor;
      _urlClick = $v.urlClick;
      _urlPreview = $v.urlPreview;
      _leaveProtocolMessage = $v.leaveProtocolMessage;
      _parentChatRoomDocumentReference = $v.parentChatRoomDocumentReference;
      _subChatRoomCount = $v.subChatRoomCount;
      _noOfMessages = $v.noOfMessages;
      _isSubChatRoom = $v.isSubChatRoom;
      _readOnly = $v.readOnly;
      _createdAt = $v.createdAt;
      _introImagePath = $v.introImagePath;
      _introText = $v.introText;
      _introSeenBy = $v.introSeenBy?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRoomsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatRoomsRecord;
  }

  @override
  void update(void Function(ChatRoomsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRoomsRecord build() => _build();

  _$ChatRoomsRecord _build() {
    _$ChatRoomsRecord _$result;
    try {
      _$result = _$v ??
          new _$ChatRoomsRecord._(
              userDocumentReferences: _userDocumentReferences?.build(),
              lastMessage: lastMessage,
              lastMessageSentAt: lastMessageSentAt,
              lastMessageSeenBy: _lastMessageSeenBy?.build(),
              lastMessageSentBy: lastMessageSentBy,
              title: title,
              unsubscribedUserDocumentReferences:
                  _unsubscribedUserDocumentReferences?.build(),
              moderatorUserDocumentReferences:
                  _moderatorUserDocumentReferences?.build(),
              isGroupChat: isGroupChat,
              isOpenChat: isOpenChat,
              reminder: reminder,
              lastMessageUploadUrl: lastMessageUploadUrl,
              backgroundColor: backgroundColor,
              urlClick: urlClick,
              urlPreview: urlPreview,
              leaveProtocolMessage: leaveProtocolMessage,
              parentChatRoomDocumentReference: parentChatRoomDocumentReference,
              subChatRoomCount: subChatRoomCount,
              noOfMessages: noOfMessages,
              isSubChatRoom: isSubChatRoom,
              readOnly: readOnly,
              createdAt: createdAt,
              introImagePath: introImagePath,
              introText: introText,
              introSeenBy: _introSeenBy?.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userDocumentReferences';
        _userDocumentReferences?.build();

        _$failedField = 'lastMessageSeenBy';
        _lastMessageSeenBy?.build();

        _$failedField = 'unsubscribedUserDocumentReferences';
        _unsubscribedUserDocumentReferences?.build();
        _$failedField = 'moderatorUserDocumentReferences';
        _moderatorUserDocumentReferences?.build();

        _$failedField = 'introSeenBy';
        _introSeenBy?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ChatRoomsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
