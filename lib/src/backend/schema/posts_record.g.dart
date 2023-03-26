// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PostsRecord> _$postsRecordSerializer = new _$PostsRecordSerializer();

class _$PostsRecordSerializer implements StructuredSerializer<PostsRecord> {
  @override
  final Iterable<Type> types = const [PostsRecord, _$PostsRecord];
  @override
  final String wireName = 'PostsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, PostsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'userDocumentReference',
      serializers.serialize(object.userDocumentReference,
          specifiedType: const FullType(
              DocumentReference, const [const FullType.nullable(Object)])),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'hasPhoto',
      serializers.serialize(object.hasPhoto,
          specifiedType: const FullType(bool)),
      'noOfComments',
      serializers.serialize(object.noOfComments,
          specifiedType: const FullType(int)),
      'hasComment',
      serializers.serialize(object.hasComment,
          specifiedType: const FullType(bool)),
      'deleted',
      serializers.serialize(object.deleted,
          specifiedType: const FullType(bool)),
      'likes',
      serializers.serialize(object.likes,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                DocumentReference, const [const FullType.nullable(Object)])
          ])),
      'noOfLikes',
      serializers.serialize(object.noOfLikes,
          specifiedType: const FullType(int)),
      'hasLike',
      serializers.serialize(object.hasLike,
          specifiedType: const FullType(bool)),
      'wasPremiumUser',
      serializers.serialize(object.wasPremiumUser,
          specifiedType: const FullType(bool)),
      'emphasizePremiumUser',
      serializers.serialize(object.emphasizePremiumUser,
          specifiedType: const FullType(bool)),
      'files',
      serializers.serialize(object.files,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
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
  PostsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'userDocumentReference':
          result.userDocumentReference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ]))! as DocumentReference<Object?>;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hasPhoto':
          result.hasPhoto = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'noOfComments':
          result.noOfComments = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'hasComment':
          result.hasComment = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'likes':
          result.likes.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'noOfLikes':
          result.noOfLikes = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'hasLike':
          result.hasLike = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'wasPremiumUser':
          result.wasPremiumUser = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'emphasizePremiumUser':
          result.emphasizePremiumUser = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'files':
          result.files.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$PostsRecord extends PostsRecord {
  @override
  final String category;
  @override
  final String postId;
  @override
  final DocumentReference<Object?> userDocumentReference;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String title;
  @override
  final String content;
  @override
  final bool hasPhoto;
  @override
  final int noOfComments;
  @override
  final bool hasComment;
  @override
  final bool deleted;
  @override
  final BuiltList<DocumentReference<Object?>> likes;
  @override
  final int noOfLikes;
  @override
  final bool hasLike;
  @override
  final bool wasPremiumUser;
  @override
  final bool emphasizePremiumUser;
  @override
  final BuiltList<String> files;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$PostsRecord([void Function(PostsRecordBuilder)? updates]) =>
      (new PostsRecordBuilder()..update(updates))._build();

  _$PostsRecord._(
      {required this.category,
      required this.postId,
      required this.userDocumentReference,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      required this.content,
      required this.hasPhoto,
      required this.noOfComments,
      required this.hasComment,
      required this.deleted,
      required this.likes,
      required this.noOfLikes,
      required this.hasLike,
      required this.wasPremiumUser,
      required this.emphasizePremiumUser,
      required this.files,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(category, r'PostsRecord', 'category');
    BuiltValueNullFieldError.checkNotNull(postId, r'PostsRecord', 'postId');
    BuiltValueNullFieldError.checkNotNull(
        userDocumentReference, r'PostsRecord', 'userDocumentReference');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'PostsRecord', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'PostsRecord', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(title, r'PostsRecord', 'title');
    BuiltValueNullFieldError.checkNotNull(content, r'PostsRecord', 'content');
    BuiltValueNullFieldError.checkNotNull(hasPhoto, r'PostsRecord', 'hasPhoto');
    BuiltValueNullFieldError.checkNotNull(
        noOfComments, r'PostsRecord', 'noOfComments');
    BuiltValueNullFieldError.checkNotNull(
        hasComment, r'PostsRecord', 'hasComment');
    BuiltValueNullFieldError.checkNotNull(deleted, r'PostsRecord', 'deleted');
    BuiltValueNullFieldError.checkNotNull(likes, r'PostsRecord', 'likes');
    BuiltValueNullFieldError.checkNotNull(
        noOfLikes, r'PostsRecord', 'noOfLikes');
    BuiltValueNullFieldError.checkNotNull(hasLike, r'PostsRecord', 'hasLike');
    BuiltValueNullFieldError.checkNotNull(
        wasPremiumUser, r'PostsRecord', 'wasPremiumUser');
    BuiltValueNullFieldError.checkNotNull(
        emphasizePremiumUser, r'PostsRecord', 'emphasizePremiumUser');
    BuiltValueNullFieldError.checkNotNull(files, r'PostsRecord', 'files');
  }

  @override
  PostsRecord rebuild(void Function(PostsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostsRecordBuilder toBuilder() => new PostsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostsRecord &&
        category == other.category &&
        postId == other.postId &&
        userDocumentReference == other.userDocumentReference &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        title == other.title &&
        content == other.content &&
        hasPhoto == other.hasPhoto &&
        noOfComments == other.noOfComments &&
        hasComment == other.hasComment &&
        deleted == other.deleted &&
        likes == other.likes &&
        noOfLikes == other.noOfLikes &&
        hasLike == other.hasLike &&
        wasPremiumUser == other.wasPremiumUser &&
        emphasizePremiumUser == other.emphasizePremiumUser &&
        files == other.files &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            category
                                                                                .hashCode),
                                                                        postId
                                                                            .hashCode),
                                                                    userDocumentReference
                                                                        .hashCode),
                                                                createdAt
                                                                    .hashCode),
                                                            updatedAt.hashCode),
                                                        title.hashCode),
                                                    content.hashCode),
                                                hasPhoto.hashCode),
                                            noOfComments.hashCode),
                                        hasComment.hashCode),
                                    deleted.hashCode),
                                likes.hashCode),
                            noOfLikes.hashCode),
                        hasLike.hashCode),
                    wasPremiumUser.hashCode),
                emphasizePremiumUser.hashCode),
            files.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostsRecord')
          ..add('category', category)
          ..add('postId', postId)
          ..add('userDocumentReference', userDocumentReference)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('title', title)
          ..add('content', content)
          ..add('hasPhoto', hasPhoto)
          ..add('noOfComments', noOfComments)
          ..add('hasComment', hasComment)
          ..add('deleted', deleted)
          ..add('likes', likes)
          ..add('noOfLikes', noOfLikes)
          ..add('hasLike', hasLike)
          ..add('wasPremiumUser', wasPremiumUser)
          ..add('emphasizePremiumUser', emphasizePremiumUser)
          ..add('files', files)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class PostsRecordBuilder implements Builder<PostsRecord, PostsRecordBuilder> {
  _$PostsRecord? _$v;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  DocumentReference<Object?>? _userDocumentReference;
  DocumentReference<Object?>? get userDocumentReference =>
      _$this._userDocumentReference;
  set userDocumentReference(
          DocumentReference<Object?>? userDocumentReference) =>
      _$this._userDocumentReference = userDocumentReference;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  bool? _hasPhoto;
  bool? get hasPhoto => _$this._hasPhoto;
  set hasPhoto(bool? hasPhoto) => _$this._hasPhoto = hasPhoto;

  int? _noOfComments;
  int? get noOfComments => _$this._noOfComments;
  set noOfComments(int? noOfComments) => _$this._noOfComments = noOfComments;

  bool? _hasComment;
  bool? get hasComment => _$this._hasComment;
  set hasComment(bool? hasComment) => _$this._hasComment = hasComment;

  bool? _deleted;
  bool? get deleted => _$this._deleted;
  set deleted(bool? deleted) => _$this._deleted = deleted;

  ListBuilder<DocumentReference<Object?>>? _likes;
  ListBuilder<DocumentReference<Object?>> get likes =>
      _$this._likes ??= new ListBuilder<DocumentReference<Object?>>();
  set likes(ListBuilder<DocumentReference<Object?>>? likes) =>
      _$this._likes = likes;

  int? _noOfLikes;
  int? get noOfLikes => _$this._noOfLikes;
  set noOfLikes(int? noOfLikes) => _$this._noOfLikes = noOfLikes;

  bool? _hasLike;
  bool? get hasLike => _$this._hasLike;
  set hasLike(bool? hasLike) => _$this._hasLike = hasLike;

  bool? _wasPremiumUser;
  bool? get wasPremiumUser => _$this._wasPremiumUser;
  set wasPremiumUser(bool? wasPremiumUser) =>
      _$this._wasPremiumUser = wasPremiumUser;

  bool? _emphasizePremiumUser;
  bool? get emphasizePremiumUser => _$this._emphasizePremiumUser;
  set emphasizePremiumUser(bool? emphasizePremiumUser) =>
      _$this._emphasizePremiumUser = emphasizePremiumUser;

  ListBuilder<String>? _files;
  ListBuilder<String> get files => _$this._files ??= new ListBuilder<String>();
  set files(ListBuilder<String>? files) => _$this._files = files;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  PostsRecordBuilder() {
    PostsRecord._initializeBuilder(this);
  }

  PostsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _postId = $v.postId;
      _userDocumentReference = $v.userDocumentReference;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _title = $v.title;
      _content = $v.content;
      _hasPhoto = $v.hasPhoto;
      _noOfComments = $v.noOfComments;
      _hasComment = $v.hasComment;
      _deleted = $v.deleted;
      _likes = $v.likes.toBuilder();
      _noOfLikes = $v.noOfLikes;
      _hasLike = $v.hasLike;
      _wasPremiumUser = $v.wasPremiumUser;
      _emphasizePremiumUser = $v.emphasizePremiumUser;
      _files = $v.files.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PostsRecord;
  }

  @override
  void update(void Function(PostsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostsRecord build() => _build();

  _$PostsRecord _build() {
    _$PostsRecord _$result;
    try {
      _$result = _$v ??
          new _$PostsRecord._(
              category: BuiltValueNullFieldError.checkNotNull(
                  category, r'PostsRecord', 'category'),
              postId: BuiltValueNullFieldError.checkNotNull(
                  postId, r'PostsRecord', 'postId'),
              userDocumentReference: BuiltValueNullFieldError.checkNotNull(
                  userDocumentReference, r'PostsRecord', 'userDocumentReference'),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'PostsRecord', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'PostsRecord', 'updatedAt'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'PostsRecord', 'title'),
              content: BuiltValueNullFieldError.checkNotNull(
                  content, r'PostsRecord', 'content'),
              hasPhoto: BuiltValueNullFieldError.checkNotNull(
                  hasPhoto, r'PostsRecord', 'hasPhoto'),
              noOfComments: BuiltValueNullFieldError.checkNotNull(noOfComments, r'PostsRecord', 'noOfComments'),
              hasComment: BuiltValueNullFieldError.checkNotNull(hasComment, r'PostsRecord', 'hasComment'),
              deleted: BuiltValueNullFieldError.checkNotNull(deleted, r'PostsRecord', 'deleted'),
              likes: likes.build(),
              noOfLikes: BuiltValueNullFieldError.checkNotNull(noOfLikes, r'PostsRecord', 'noOfLikes'),
              hasLike: BuiltValueNullFieldError.checkNotNull(hasLike, r'PostsRecord', 'hasLike'),
              wasPremiumUser: BuiltValueNullFieldError.checkNotNull(wasPremiumUser, r'PostsRecord', 'wasPremiumUser'),
              emphasizePremiumUser: BuiltValueNullFieldError.checkNotNull(emphasizePremiumUser, r'PostsRecord', 'emphasizePremiumUser'),
              files: files.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'likes';
        likes.build();

        _$failedField = 'files';
        files.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PostsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
