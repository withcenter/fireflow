// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_public_data_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersPublicDataRecord> _$usersPublicDataRecordSerializer =
    new _$UsersPublicDataRecordSerializer();

class _$UsersPublicDataRecordSerializer
    implements StructuredSerializer<UsersPublicDataRecord> {
  @override
  final Iterable<Type> types = const [
    UsersPublicDataRecord,
    _$UsersPublicDataRecord
  ];
  @override
  final String wireName = 'UsersPublicDataRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UsersPublicDataRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'lastPost',
      serializers.serialize(object.lastPost,
          specifiedType: const FullType(RecentPostsStruct)),
    ];
    Object? value;
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userDocumentReference;
    if (value != null) {
      result
        ..add('userDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.registeredAt;
    if (value != null) {
      result
        ..add('registeredAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
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
    value = object.coverPhotoUrl;
    if (value != null) {
      result
        ..add('coverPhotoUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('gender')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.birthday;
    if (value != null) {
      result
        ..add('birthday')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.hasPhoto;
    if (value != null) {
      result
        ..add('hasPhoto')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isProfileComplete;
    if (value != null) {
      result
        ..add('isProfileComplete')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.lastPostCreatedAt;
    if (value != null) {
      result
        ..add('lastPostCreatedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.recentPosts;
    if (value != null) {
      result
        ..add('recentPosts')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(RecentPostsStruct)])));
    }
    value = object.isPremiumUser;
    if (value != null) {
      result
        ..add('isPremiumUser')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.noOfPosts;
    if (value != null) {
      result
        ..add('noOfPosts')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.noOfComments;
    if (value != null) {
      result
        ..add('noOfComments')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.followings;
    if (value != null) {
      result
        ..add('followings')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.referral;
    if (value != null) {
      result
        ..add('referral')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.referralAcceptedAt;
    if (value != null) {
      result
        ..add('referralAcceptedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.stateMessage;
    if (value != null) {
      result
        ..add('stateMessage')
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
  UsersPublicDataRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersPublicDataRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'userDocumentReference':
          result.userDocumentReference = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'registeredAt':
          result.registeredAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'coverPhotoUrl':
          result.coverPhotoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'gender':
          result.gender = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'birthday':
          result.birthday = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'hasPhoto':
          result.hasPhoto = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isProfileComplete':
          result.isProfileComplete = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'lastPostCreatedAt':
          result.lastPostCreatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'lastPost':
          result.lastPost.replace(serializers.deserialize(value,
                  specifiedType: const FullType(RecentPostsStruct))!
              as RecentPostsStruct);
          break;
        case 'recentPosts':
          result.recentPosts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(RecentPostsStruct)]))!
              as BuiltList<Object?>);
          break;
        case 'isPremiumUser':
          result.isPremiumUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'noOfPosts':
          result.noOfPosts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'noOfComments':
          result.noOfComments = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'followings':
          result.followings.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'referral':
          result.referral = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'referralAcceptedAt':
          result.referralAcceptedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'stateMessage':
          result.stateMessage = serializers.deserialize(value,
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

class _$UsersPublicDataRecord extends UsersPublicDataRecord {
  @override
  final String? uid;
  @override
  final DocumentReference<Object?>? userDocumentReference;
  @override
  final DateTime? registeredAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? coverPhotoUrl;
  @override
  final String? gender;
  @override
  final DateTime? birthday;
  @override
  final bool? hasPhoto;
  @override
  final bool? isProfileComplete;
  @override
  final DateTime? lastPostCreatedAt;
  @override
  final RecentPostsStruct lastPost;
  @override
  final BuiltList<RecentPostsStruct>? recentPosts;
  @override
  final bool? isPremiumUser;
  @override
  final int? noOfPosts;
  @override
  final int? noOfComments;
  @override
  final BuiltList<DocumentReference<Object?>>? followings;
  @override
  final DocumentReference<Object?>? referral;
  @override
  final DateTime? referralAcceptedAt;
  @override
  final String? stateMessage;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UsersPublicDataRecord(
          [void Function(UsersPublicDataRecordBuilder)? updates]) =>
      (new UsersPublicDataRecordBuilder()..update(updates))._build();

  _$UsersPublicDataRecord._(
      {this.uid,
      this.userDocumentReference,
      this.registeredAt,
      this.updatedAt,
      this.displayName,
      this.photoUrl,
      this.coverPhotoUrl,
      this.gender,
      this.birthday,
      this.hasPhoto,
      this.isProfileComplete,
      this.lastPostCreatedAt,
      required this.lastPost,
      this.recentPosts,
      this.isPremiumUser,
      this.noOfPosts,
      this.noOfComments,
      this.followings,
      this.referral,
      this.referralAcceptedAt,
      this.stateMessage,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        lastPost, r'UsersPublicDataRecord', 'lastPost');
  }

  @override
  UsersPublicDataRecord rebuild(
          void Function(UsersPublicDataRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersPublicDataRecordBuilder toBuilder() =>
      new UsersPublicDataRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersPublicDataRecord &&
        uid == other.uid &&
        userDocumentReference == other.userDocumentReference &&
        registeredAt == other.registeredAt &&
        updatedAt == other.updatedAt &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        coverPhotoUrl == other.coverPhotoUrl &&
        gender == other.gender &&
        birthday == other.birthday &&
        hasPhoto == other.hasPhoto &&
        isProfileComplete == other.isProfileComplete &&
        lastPostCreatedAt == other.lastPostCreatedAt &&
        lastPost == other.lastPost &&
        recentPosts == other.recentPosts &&
        isPremiumUser == other.isPremiumUser &&
        noOfPosts == other.noOfPosts &&
        noOfComments == other.noOfComments &&
        followings == other.followings &&
        referral == other.referral &&
        referralAcceptedAt == other.referralAcceptedAt &&
        stateMessage == other.stateMessage &&
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
                                                                            $jc($jc($jc($jc(0, uid.hashCode), userDocumentReference.hashCode), registeredAt.hashCode),
                                                                                updatedAt.hashCode),
                                                                            displayName.hashCode),
                                                                        photoUrl.hashCode),
                                                                    coverPhotoUrl.hashCode),
                                                                gender.hashCode),
                                                            birthday.hashCode),
                                                        hasPhoto.hashCode),
                                                    isProfileComplete.hashCode),
                                                lastPostCreatedAt.hashCode),
                                            lastPost.hashCode),
                                        recentPosts.hashCode),
                                    isPremiumUser.hashCode),
                                noOfPosts.hashCode),
                            noOfComments.hashCode),
                        followings.hashCode),
                    referral.hashCode),
                referralAcceptedAt.hashCode),
            stateMessage.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersPublicDataRecord')
          ..add('uid', uid)
          ..add('userDocumentReference', userDocumentReference)
          ..add('registeredAt', registeredAt)
          ..add('updatedAt', updatedAt)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('coverPhotoUrl', coverPhotoUrl)
          ..add('gender', gender)
          ..add('birthday', birthday)
          ..add('hasPhoto', hasPhoto)
          ..add('isProfileComplete', isProfileComplete)
          ..add('lastPostCreatedAt', lastPostCreatedAt)
          ..add('lastPost', lastPost)
          ..add('recentPosts', recentPosts)
          ..add('isPremiumUser', isPremiumUser)
          ..add('noOfPosts', noOfPosts)
          ..add('noOfComments', noOfComments)
          ..add('followings', followings)
          ..add('referral', referral)
          ..add('referralAcceptedAt', referralAcceptedAt)
          ..add('stateMessage', stateMessage)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UsersPublicDataRecordBuilder
    implements Builder<UsersPublicDataRecord, UsersPublicDataRecordBuilder> {
  _$UsersPublicDataRecord? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  DocumentReference<Object?>? _userDocumentReference;
  DocumentReference<Object?>? get userDocumentReference =>
      _$this._userDocumentReference;
  set userDocumentReference(
          DocumentReference<Object?>? userDocumentReference) =>
      _$this._userDocumentReference = userDocumentReference;

  DateTime? _registeredAt;
  DateTime? get registeredAt => _$this._registeredAt;
  set registeredAt(DateTime? registeredAt) =>
      _$this._registeredAt = registeredAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _coverPhotoUrl;
  String? get coverPhotoUrl => _$this._coverPhotoUrl;
  set coverPhotoUrl(String? coverPhotoUrl) =>
      _$this._coverPhotoUrl = coverPhotoUrl;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  DateTime? _birthday;
  DateTime? get birthday => _$this._birthday;
  set birthday(DateTime? birthday) => _$this._birthday = birthday;

  bool? _hasPhoto;
  bool? get hasPhoto => _$this._hasPhoto;
  set hasPhoto(bool? hasPhoto) => _$this._hasPhoto = hasPhoto;

  bool? _isProfileComplete;
  bool? get isProfileComplete => _$this._isProfileComplete;
  set isProfileComplete(bool? isProfileComplete) =>
      _$this._isProfileComplete = isProfileComplete;

  DateTime? _lastPostCreatedAt;
  DateTime? get lastPostCreatedAt => _$this._lastPostCreatedAt;
  set lastPostCreatedAt(DateTime? lastPostCreatedAt) =>
      _$this._lastPostCreatedAt = lastPostCreatedAt;

  RecentPostsStructBuilder? _lastPost;
  RecentPostsStructBuilder get lastPost =>
      _$this._lastPost ??= new RecentPostsStructBuilder();
  set lastPost(RecentPostsStructBuilder? lastPost) =>
      _$this._lastPost = lastPost;

  ListBuilder<RecentPostsStruct>? _recentPosts;
  ListBuilder<RecentPostsStruct> get recentPosts =>
      _$this._recentPosts ??= new ListBuilder<RecentPostsStruct>();
  set recentPosts(ListBuilder<RecentPostsStruct>? recentPosts) =>
      _$this._recentPosts = recentPosts;

  bool? _isPremiumUser;
  bool? get isPremiumUser => _$this._isPremiumUser;
  set isPremiumUser(bool? isPremiumUser) =>
      _$this._isPremiumUser = isPremiumUser;

  int? _noOfPosts;
  int? get noOfPosts => _$this._noOfPosts;
  set noOfPosts(int? noOfPosts) => _$this._noOfPosts = noOfPosts;

  int? _noOfComments;
  int? get noOfComments => _$this._noOfComments;
  set noOfComments(int? noOfComments) => _$this._noOfComments = noOfComments;

  ListBuilder<DocumentReference<Object?>>? _followings;
  ListBuilder<DocumentReference<Object?>> get followings =>
      _$this._followings ??= new ListBuilder<DocumentReference<Object?>>();
  set followings(ListBuilder<DocumentReference<Object?>>? followings) =>
      _$this._followings = followings;

  DocumentReference<Object?>? _referral;
  DocumentReference<Object?>? get referral => _$this._referral;
  set referral(DocumentReference<Object?>? referral) =>
      _$this._referral = referral;

  DateTime? _referralAcceptedAt;
  DateTime? get referralAcceptedAt => _$this._referralAcceptedAt;
  set referralAcceptedAt(DateTime? referralAcceptedAt) =>
      _$this._referralAcceptedAt = referralAcceptedAt;

  String? _stateMessage;
  String? get stateMessage => _$this._stateMessage;
  set stateMessage(String? stateMessage) => _$this._stateMessage = stateMessage;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UsersPublicDataRecordBuilder() {
    UsersPublicDataRecord._initializeBuilder(this);
  }

  UsersPublicDataRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _userDocumentReference = $v.userDocumentReference;
      _registeredAt = $v.registeredAt;
      _updatedAt = $v.updatedAt;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _coverPhotoUrl = $v.coverPhotoUrl;
      _gender = $v.gender;
      _birthday = $v.birthday;
      _hasPhoto = $v.hasPhoto;
      _isProfileComplete = $v.isProfileComplete;
      _lastPostCreatedAt = $v.lastPostCreatedAt;
      _lastPost = $v.lastPost.toBuilder();
      _recentPosts = $v.recentPosts?.toBuilder();
      _isPremiumUser = $v.isPremiumUser;
      _noOfPosts = $v.noOfPosts;
      _noOfComments = $v.noOfComments;
      _followings = $v.followings?.toBuilder();
      _referral = $v.referral;
      _referralAcceptedAt = $v.referralAcceptedAt;
      _stateMessage = $v.stateMessage;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersPublicDataRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersPublicDataRecord;
  }

  @override
  void update(void Function(UsersPublicDataRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersPublicDataRecord build() => _build();

  _$UsersPublicDataRecord _build() {
    _$UsersPublicDataRecord _$result;
    try {
      _$result = _$v ??
          new _$UsersPublicDataRecord._(
              uid: uid,
              userDocumentReference: userDocumentReference,
              registeredAt: registeredAt,
              updatedAt: updatedAt,
              displayName: displayName,
              photoUrl: photoUrl,
              coverPhotoUrl: coverPhotoUrl,
              gender: gender,
              birthday: birthday,
              hasPhoto: hasPhoto,
              isProfileComplete: isProfileComplete,
              lastPostCreatedAt: lastPostCreatedAt,
              lastPost: lastPost.build(),
              recentPosts: _recentPosts?.build(),
              isPremiumUser: isPremiumUser,
              noOfPosts: noOfPosts,
              noOfComments: noOfComments,
              followings: _followings?.build(),
              referral: referral,
              referralAcceptedAt: referralAcceptedAt,
              stateMessage: stateMessage,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lastPost';
        lastPost.build();
        _$failedField = 'recentPosts';
        _recentPosts?.build();

        _$failedField = 'followings';
        _followings?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UsersPublicDataRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
