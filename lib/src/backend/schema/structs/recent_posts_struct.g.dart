// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_posts_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecentPostsStruct> _$recentPostsStructSerializer =
    new _$RecentPostsStructSerializer();

class _$RecentPostsStructSerializer
    implements StructuredSerializer<RecentPostsStruct> {
  @override
  final Iterable<Type> types = const [RecentPostsStruct, _$RecentPostsStruct];
  @override
  final String wireName = 'RecentPostsStruct';

  @override
  Iterable<Object?> serialize(Serializers serializers, RecentPostsStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.postDocumentReference;
    if (value != null) {
      result
        ..add('postDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photoUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  RecentPostsStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecentPostsStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postDocumentReference':
          result.postDocumentReference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'firestoreUtilData':
          result.firestoreUtilData = serializers.deserialize(value,
                  specifiedType: const FullType(FirestoreUtilData))!
              as FirestoreUtilData;
          break;
      }
    }

    return result.build();
  }
}

class _$RecentPostsStruct extends RecentPostsStruct {
  @override
  final DocumentReference<Object?>? postDocumentReference;
  @override
  final DateTime? createdAt;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? photoUrl;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$RecentPostsStruct(
          [void Function(RecentPostsStructBuilder)? updates]) =>
      (new RecentPostsStructBuilder()..update(updates))._build();

  _$RecentPostsStruct._(
      {this.postDocumentReference,
      this.createdAt,
      this.title,
      this.content,
      this.photoUrl,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'RecentPostsStruct', 'firestoreUtilData');
  }

  @override
  RecentPostsStruct rebuild(void Function(RecentPostsStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecentPostsStructBuilder toBuilder() =>
      new RecentPostsStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecentPostsStruct &&
        postDocumentReference == other.postDocumentReference &&
        createdAt == other.createdAt &&
        title == other.title &&
        content == other.content &&
        photoUrl == other.photoUrl &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc(0, postDocumentReference.hashCode),
                        createdAt.hashCode),
                    title.hashCode),
                content.hashCode),
            photoUrl.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecentPostsStruct')
          ..add('postDocumentReference', postDocumentReference)
          ..add('createdAt', createdAt)
          ..add('title', title)
          ..add('content', content)
          ..add('photoUrl', photoUrl)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class RecentPostsStructBuilder
    implements Builder<RecentPostsStruct, RecentPostsStructBuilder> {
  _$RecentPostsStruct? _$v;

  DocumentReference<Object?>? _postDocumentReference;
  DocumentReference<Object?>? get postDocumentReference =>
      _$this._postDocumentReference;
  set postDocumentReference(
          DocumentReference<Object?>? postDocumentReference) =>
      _$this._postDocumentReference = postDocumentReference;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  RecentPostsStructBuilder() {
    RecentPostsStruct._initializeBuilder(this);
  }

  RecentPostsStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postDocumentReference = $v.postDocumentReference;
      _createdAt = $v.createdAt;
      _title = $v.title;
      _content = $v.content;
      _photoUrl = $v.photoUrl;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecentPostsStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecentPostsStruct;
  }

  @override
  void update(void Function(RecentPostsStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecentPostsStruct build() => _build();

  _$RecentPostsStruct _build() {
    final _$result = _$v ??
        new _$RecentPostsStruct._(
            postDocumentReference: postDocumentReference,
            createdAt: createdAt,
            title: title,
            content: content,
            photoUrl: photoUrl,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData, r'RecentPostsStruct', 'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
