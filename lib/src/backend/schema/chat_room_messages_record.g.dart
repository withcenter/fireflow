// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_messages_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatRoomMessagesRecord> _$chatRoomMessagesRecordSerializer =
    new _$ChatRoomMessagesRecordSerializer();

class _$ChatRoomMessagesRecordSerializer
    implements StructuredSerializer<ChatRoomMessagesRecord> {
  @override
  final Iterable<Type> types = const [
    ChatRoomMessagesRecord,
    _$ChatRoomMessagesRecord
  ];
  @override
  final String wireName = 'ChatRoomMessagesRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ChatRoomMessagesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.userDocumentReference;
    if (value != null) {
      result
        ..add('userDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.chatRoomDocumentReference;
    if (value != null) {
      result
        ..add('chatRoomDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.text;
    if (value != null) {
      result
        ..add('text')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.sentAt;
    if (value != null) {
      result
        ..add('sentAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.uploadUrl;
    if (value != null) {
      result
        ..add('uploadUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uploadUrlType;
    if (value != null) {
      result
        ..add('uploadUrlType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.protocol;
    if (value != null) {
      result
        ..add('protocol')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.protocolTargetUserDocumentReference;
    if (value != null) {
      result
        ..add('protocolTargetUserDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.previewUrl;
    if (value != null) {
      result
        ..add('previewUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.previewTitle;
    if (value != null) {
      result
        ..add('previewTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.previewDescription;
    if (value != null) {
      result
        ..add('previewDescription')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.previewImageUrl;
    if (value != null) {
      result
        ..add('previewImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.replyDisplayName;
    if (value != null) {
      result
        ..add('replyDisplayName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.replyText;
    if (value != null) {
      result
        ..add('replyText')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  ChatRoomMessagesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatRoomMessagesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userDocumentReference':
          result.userDocumentReference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'chatRoomDocumentReference':
          result.chatRoomDocumentReference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sentAt':
          result.sentAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'uploadUrl':
          result.uploadUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uploadUrlType':
          result.uploadUrlType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'protocol':
          result.protocol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'protocolTargetUserDocumentReference':
          result.protocolTargetUserDocumentReference = serializers.deserialize(
              value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'previewUrl':
          result.previewUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'previewTitle':
          result.previewTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'previewDescription':
          result.previewDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'previewImageUrl':
          result.previewImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'replyDisplayName':
          result.replyDisplayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'replyText':
          result.replyText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$ChatRoomMessagesRecord extends ChatRoomMessagesRecord {
  @override
  final DocumentReference<Object?>? userDocumentReference;
  @override
  final DocumentReference<Object?>? chatRoomDocumentReference;
  @override
  final String? text;
  @override
  final DateTime? sentAt;
  @override
  final String? uploadUrl;
  @override
  final String? uploadUrlType;
  @override
  final String? protocol;
  @override
  final DocumentReference<Object?>? protocolTargetUserDocumentReference;
  @override
  final String? previewUrl;
  @override
  final String? previewTitle;
  @override
  final String? previewDescription;
  @override
  final String? previewImageUrl;
  @override
  final String? replyDisplayName;
  @override
  final String? replyText;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ChatRoomMessagesRecord(
          [void Function(ChatRoomMessagesRecordBuilder)? updates]) =>
      (new ChatRoomMessagesRecordBuilder()..update(updates))._build();

  _$ChatRoomMessagesRecord._(
      {this.userDocumentReference,
      this.chatRoomDocumentReference,
      this.text,
      this.sentAt,
      this.uploadUrl,
      this.uploadUrlType,
      this.protocol,
      this.protocolTargetUserDocumentReference,
      this.previewUrl,
      this.previewTitle,
      this.previewDescription,
      this.previewImageUrl,
      this.replyDisplayName,
      this.replyText,
      this.ffRef})
      : super._();

  @override
  ChatRoomMessagesRecord rebuild(
          void Function(ChatRoomMessagesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRoomMessagesRecordBuilder toBuilder() =>
      new ChatRoomMessagesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRoomMessagesRecord &&
        userDocumentReference == other.userDocumentReference &&
        chatRoomDocumentReference == other.chatRoomDocumentReference &&
        text == other.text &&
        sentAt == other.sentAt &&
        uploadUrl == other.uploadUrl &&
        uploadUrlType == other.uploadUrlType &&
        protocol == other.protocol &&
        protocolTargetUserDocumentReference ==
            other.protocolTargetUserDocumentReference &&
        previewUrl == other.previewUrl &&
        previewTitle == other.previewTitle &&
        previewDescription == other.previewDescription &&
        previewImageUrl == other.previewImageUrl &&
        replyDisplayName == other.replyDisplayName &&
        replyText == other.replyText &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userDocumentReference.hashCode);
    _$hash = $jc(_$hash, chatRoomDocumentReference.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, sentAt.hashCode);
    _$hash = $jc(_$hash, uploadUrl.hashCode);
    _$hash = $jc(_$hash, uploadUrlType.hashCode);
    _$hash = $jc(_$hash, protocol.hashCode);
    _$hash = $jc(_$hash, protocolTargetUserDocumentReference.hashCode);
    _$hash = $jc(_$hash, previewUrl.hashCode);
    _$hash = $jc(_$hash, previewTitle.hashCode);
    _$hash = $jc(_$hash, previewDescription.hashCode);
    _$hash = $jc(_$hash, previewImageUrl.hashCode);
    _$hash = $jc(_$hash, replyDisplayName.hashCode);
    _$hash = $jc(_$hash, replyText.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRoomMessagesRecord')
          ..add('userDocumentReference', userDocumentReference)
          ..add('chatRoomDocumentReference', chatRoomDocumentReference)
          ..add('text', text)
          ..add('sentAt', sentAt)
          ..add('uploadUrl', uploadUrl)
          ..add('uploadUrlType', uploadUrlType)
          ..add('protocol', protocol)
          ..add('protocolTargetUserDocumentReference',
              protocolTargetUserDocumentReference)
          ..add('previewUrl', previewUrl)
          ..add('previewTitle', previewTitle)
          ..add('previewDescription', previewDescription)
          ..add('previewImageUrl', previewImageUrl)
          ..add('replyDisplayName', replyDisplayName)
          ..add('replyText', replyText)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ChatRoomMessagesRecordBuilder
    implements Builder<ChatRoomMessagesRecord, ChatRoomMessagesRecordBuilder> {
  _$ChatRoomMessagesRecord? _$v;

  DocumentReference<Object?>? _userDocumentReference;
  DocumentReference<Object?>? get userDocumentReference =>
      _$this._userDocumentReference;
  set userDocumentReference(
          DocumentReference<Object?>? userDocumentReference) =>
      _$this._userDocumentReference = userDocumentReference;

  DocumentReference<Object?>? _chatRoomDocumentReference;
  DocumentReference<Object?>? get chatRoomDocumentReference =>
      _$this._chatRoomDocumentReference;
  set chatRoomDocumentReference(
          DocumentReference<Object?>? chatRoomDocumentReference) =>
      _$this._chatRoomDocumentReference = chatRoomDocumentReference;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  DateTime? _sentAt;
  DateTime? get sentAt => _$this._sentAt;
  set sentAt(DateTime? sentAt) => _$this._sentAt = sentAt;

  String? _uploadUrl;
  String? get uploadUrl => _$this._uploadUrl;
  set uploadUrl(String? uploadUrl) => _$this._uploadUrl = uploadUrl;

  String? _uploadUrlType;
  String? get uploadUrlType => _$this._uploadUrlType;
  set uploadUrlType(String? uploadUrlType) =>
      _$this._uploadUrlType = uploadUrlType;

  String? _protocol;
  String? get protocol => _$this._protocol;
  set protocol(String? protocol) => _$this._protocol = protocol;

  DocumentReference<Object?>? _protocolTargetUserDocumentReference;
  DocumentReference<Object?>? get protocolTargetUserDocumentReference =>
      _$this._protocolTargetUserDocumentReference;
  set protocolTargetUserDocumentReference(
          DocumentReference<Object?>? protocolTargetUserDocumentReference) =>
      _$this._protocolTargetUserDocumentReference =
          protocolTargetUserDocumentReference;

  String? _previewUrl;
  String? get previewUrl => _$this._previewUrl;
  set previewUrl(String? previewUrl) => _$this._previewUrl = previewUrl;

  String? _previewTitle;
  String? get previewTitle => _$this._previewTitle;
  set previewTitle(String? previewTitle) => _$this._previewTitle = previewTitle;

  String? _previewDescription;
  String? get previewDescription => _$this._previewDescription;
  set previewDescription(String? previewDescription) =>
      _$this._previewDescription = previewDescription;

  String? _previewImageUrl;
  String? get previewImageUrl => _$this._previewImageUrl;
  set previewImageUrl(String? previewImageUrl) =>
      _$this._previewImageUrl = previewImageUrl;

  String? _replyDisplayName;
  String? get replyDisplayName => _$this._replyDisplayName;
  set replyDisplayName(String? replyDisplayName) =>
      _$this._replyDisplayName = replyDisplayName;

  String? _replyText;
  String? get replyText => _$this._replyText;
  set replyText(String? replyText) => _$this._replyText = replyText;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ChatRoomMessagesRecordBuilder() {
    ChatRoomMessagesRecord._initializeBuilder(this);
  }

  ChatRoomMessagesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userDocumentReference = $v.userDocumentReference;
      _chatRoomDocumentReference = $v.chatRoomDocumentReference;
      _text = $v.text;
      _sentAt = $v.sentAt;
      _uploadUrl = $v.uploadUrl;
      _uploadUrlType = $v.uploadUrlType;
      _protocol = $v.protocol;
      _protocolTargetUserDocumentReference =
          $v.protocolTargetUserDocumentReference;
      _previewUrl = $v.previewUrl;
      _previewTitle = $v.previewTitle;
      _previewDescription = $v.previewDescription;
      _previewImageUrl = $v.previewImageUrl;
      _replyDisplayName = $v.replyDisplayName;
      _replyText = $v.replyText;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRoomMessagesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatRoomMessagesRecord;
  }

  @override
  void update(void Function(ChatRoomMessagesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRoomMessagesRecord build() => _build();

  _$ChatRoomMessagesRecord _build() {
    final _$result = _$v ??
        new _$ChatRoomMessagesRecord._(
            userDocumentReference: userDocumentReference,
            chatRoomDocumentReference: chatRoomDocumentReference,
            text: text,
            sentAt: sentAt,
            uploadUrl: uploadUrl,
            uploadUrlType: uploadUrlType,
            protocol: protocol,
            protocolTargetUserDocumentReference:
                protocolTargetUserDocumentReference,
            previewUrl: previewUrl,
            previewTitle: previewTitle,
            previewDescription: previewDescription,
            previewImageUrl: previewImageUrl,
            replyDisplayName: replyDisplayName,
            replyText: replyText,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
