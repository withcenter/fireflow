// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRecord> _$usersRecordSerializer = new _$UsersRecordSerializer();

class _$UsersRecordSerializer implements StructuredSerializer<UsersRecord> {
  @override
  final Iterable<Type> types = const [UsersRecord, _$UsersRecord];
  @override
  final String wireName = 'UsersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'created_time',
      serializers.serialize(object.createdTime,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
      'admin',
      serializers.serialize(object.admin, specifiedType: const FullType(bool)),
      'blockedUsers',
      serializers.serialize(object.blockedUsers,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                DocumentReference, const [const FullType.nullable(Object)])
          ])),
      'isProfileComplete',
      serializers.serialize(object.isProfileComplete,
          specifiedType: const FullType(bool)),
      'hasPhoto',
      serializers.serialize(object.hasPhoto,
          specifiedType: const FullType(bool)),
      'lastPost',
      serializers.serialize(object.lastPost,
          specifiedType: const FullType(RecentPostsStruct)),
      'noOfPosts',
      serializers.serialize(object.noOfPosts,
          specifiedType: const FullType(int)),
      'noOfComments',
      serializers.serialize(object.noOfComments,
          specifiedType: const FullType(int)),
      'followings',
      serializers.serialize(object.followings,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                DocumentReference, const [const FullType.nullable(Object)])
          ])),
      'favoriteChatRooms',
      serializers.serialize(object.favoriteChatRooms,
          specifiedType: const FullType(BuiltList, const [
            const FullType(
                DocumentReference, const [const FullType.nullable(Object)])
          ])),
    ];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
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
  UsersRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'admin':
          result.admin = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'blockedUsers':
          result.blockedUsers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'isProfileComplete':
          result.isProfileComplete = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
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
              specifiedType: const FullType(bool))! as bool;
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
              specifiedType: const FullType(int))! as int;
          break;
        case 'noOfComments':
          result.noOfComments = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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
        case 'favoriteChatRooms':
          result.favoriteChatRooms.replace(serializers.deserialize(value,
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

class _$UsersRecord extends UsersRecord {
  @override
  final String? email;
  @override
  final String displayName;
  @override
  final String? photoUrl;
  @override
  final String uid;
  @override
  final DateTime createdTime;
  @override
  final DateTime updatedAt;
  @override
  final String? phoneNumber;
  @override
  final bool admin;
  @override
  final BuiltList<DocumentReference<Object?>> blockedUsers;
  @override
  final bool isProfileComplete;
  @override
  final String? name;
  @override
  final String? coverPhotoUrl;
  @override
  final String? gender;
  @override
  final DateTime? birthday;
  @override
  final bool hasPhoto;
  @override
  final DateTime? lastPostCreatedAt;
  @override
  final RecentPostsStruct lastPost;
  @override
  final BuiltList<RecentPostsStruct>? recentPosts;
  @override
  final bool? isPremiumUser;
  @override
  final int noOfPosts;
  @override
  final int noOfComments;
  @override
  final BuiltList<DocumentReference<Object?>> followings;
  @override
  final DocumentReference<Object?>? referral;
  @override
  final DateTime? referralAcceptedAt;
  @override
  final String? stateMessage;
  @override
  final BuiltList<DocumentReference<Object?>> favoriteChatRooms;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UsersRecord([void Function(UsersRecordBuilder)? updates]) =>
      (new UsersRecordBuilder()..update(updates))._build();

  _$UsersRecord._(
      {this.email,
      required this.displayName,
      this.photoUrl,
      required this.uid,
      required this.createdTime,
      required this.updatedAt,
      this.phoneNumber,
      required this.admin,
      required this.blockedUsers,
      required this.isProfileComplete,
      this.name,
      this.coverPhotoUrl,
      this.gender,
      this.birthday,
      required this.hasPhoto,
      this.lastPostCreatedAt,
      required this.lastPost,
      this.recentPosts,
      this.isPremiumUser,
      required this.noOfPosts,
      required this.noOfComments,
      required this.followings,
      this.referral,
      this.referralAcceptedAt,
      this.stateMessage,
      required this.favoriteChatRooms,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'UsersRecord', 'displayName');
    BuiltValueNullFieldError.checkNotNull(uid, r'UsersRecord', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        createdTime, r'UsersRecord', 'createdTime');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'UsersRecord', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(admin, r'UsersRecord', 'admin');
    BuiltValueNullFieldError.checkNotNull(
        blockedUsers, r'UsersRecord', 'blockedUsers');
    BuiltValueNullFieldError.checkNotNull(
        isProfileComplete, r'UsersRecord', 'isProfileComplete');
    BuiltValueNullFieldError.checkNotNull(hasPhoto, r'UsersRecord', 'hasPhoto');
    BuiltValueNullFieldError.checkNotNull(lastPost, r'UsersRecord', 'lastPost');
    BuiltValueNullFieldError.checkNotNull(
        noOfPosts, r'UsersRecord', 'noOfPosts');
    BuiltValueNullFieldError.checkNotNull(
        noOfComments, r'UsersRecord', 'noOfComments');
    BuiltValueNullFieldError.checkNotNull(
        followings, r'UsersRecord', 'followings');
    BuiltValueNullFieldError.checkNotNull(
        favoriteChatRooms, r'UsersRecord', 'favoriteChatRooms');
  }

  @override
  UsersRecord rebuild(void Function(UsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRecordBuilder toBuilder() => new UsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRecord &&
        email == other.email &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        updatedAt == other.updatedAt &&
        phoneNumber == other.phoneNumber &&
        admin == other.admin &&
        blockedUsers == other.blockedUsers &&
        isProfileComplete == other.isProfileComplete &&
        name == other.name &&
        coverPhotoUrl == other.coverPhotoUrl &&
        gender == other.gender &&
        birthday == other.birthday &&
        hasPhoto == other.hasPhoto &&
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
        favoriteChatRooms == other.favoriteChatRooms &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc(0, email.hashCode), displayName.hashCode), photoUrl.hashCode), uid.hashCode), createdTime.hashCode), updatedAt.hashCode), phoneNumber.hashCode), admin.hashCode),
                                                                                blockedUsers.hashCode),
                                                                            isProfileComplete.hashCode),
                                                                        name.hashCode),
                                                                    coverPhotoUrl.hashCode),
                                                                gender.hashCode),
                                                            birthday.hashCode),
                                                        hasPhoto.hashCode),
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
            favoriteChatRooms.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersRecord')
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('updatedAt', updatedAt)
          ..add('phoneNumber', phoneNumber)
          ..add('admin', admin)
          ..add('blockedUsers', blockedUsers)
          ..add('isProfileComplete', isProfileComplete)
          ..add('name', name)
          ..add('coverPhotoUrl', coverPhotoUrl)
          ..add('gender', gender)
          ..add('birthday', birthday)
          ..add('hasPhoto', hasPhoto)
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
          ..add('favoriteChatRooms', favoriteChatRooms)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UsersRecordBuilder implements Builder<UsersRecord, UsersRecordBuilder> {
  _$UsersRecord? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  DateTime? _createdTime;
  DateTime? get createdTime => _$this._createdTime;
  set createdTime(DateTime? createdTime) => _$this._createdTime = createdTime;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  bool? _admin;
  bool? get admin => _$this._admin;
  set admin(bool? admin) => _$this._admin = admin;

  ListBuilder<DocumentReference<Object?>>? _blockedUsers;
  ListBuilder<DocumentReference<Object?>> get blockedUsers =>
      _$this._blockedUsers ??= new ListBuilder<DocumentReference<Object?>>();
  set blockedUsers(ListBuilder<DocumentReference<Object?>>? blockedUsers) =>
      _$this._blockedUsers = blockedUsers;

  bool? _isProfileComplete;
  bool? get isProfileComplete => _$this._isProfileComplete;
  set isProfileComplete(bool? isProfileComplete) =>
      _$this._isProfileComplete = isProfileComplete;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

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

  ListBuilder<DocumentReference<Object?>>? _favoriteChatRooms;
  ListBuilder<DocumentReference<Object?>> get favoriteChatRooms =>
      _$this._favoriteChatRooms ??=
          new ListBuilder<DocumentReference<Object?>>();
  set favoriteChatRooms(
          ListBuilder<DocumentReference<Object?>>? favoriteChatRooms) =>
      _$this._favoriteChatRooms = favoriteChatRooms;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UsersRecordBuilder() {
    UsersRecord._initializeBuilder(this);
  }

  UsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _updatedAt = $v.updatedAt;
      _phoneNumber = $v.phoneNumber;
      _admin = $v.admin;
      _blockedUsers = $v.blockedUsers.toBuilder();
      _isProfileComplete = $v.isProfileComplete;
      _name = $v.name;
      _coverPhotoUrl = $v.coverPhotoUrl;
      _gender = $v.gender;
      _birthday = $v.birthday;
      _hasPhoto = $v.hasPhoto;
      _lastPostCreatedAt = $v.lastPostCreatedAt;
      _lastPost = $v.lastPost.toBuilder();
      _recentPosts = $v.recentPosts?.toBuilder();
      _isPremiumUser = $v.isPremiumUser;
      _noOfPosts = $v.noOfPosts;
      _noOfComments = $v.noOfComments;
      _followings = $v.followings.toBuilder();
      _referral = $v.referral;
      _referralAcceptedAt = $v.referralAcceptedAt;
      _stateMessage = $v.stateMessage;
      _favoriteChatRooms = $v.favoriteChatRooms.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRecord;
  }

  @override
  void update(void Function(UsersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersRecord build() => _build();

  _$UsersRecord _build() {
    _$UsersRecord _$result;
    try {
      _$result = _$v ??
          new _$UsersRecord._(
              email: email,
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'UsersRecord', 'displayName'),
              photoUrl: photoUrl,
              uid: BuiltValueNullFieldError.checkNotNull(
                  uid, r'UsersRecord', 'uid'),
              createdTime: BuiltValueNullFieldError.checkNotNull(
                  createdTime, r'UsersRecord', 'createdTime'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'UsersRecord', 'updatedAt'),
              phoneNumber: phoneNumber,
              admin: BuiltValueNullFieldError.checkNotNull(
                  admin, r'UsersRecord', 'admin'),
              blockedUsers: blockedUsers.build(),
              isProfileComplete: BuiltValueNullFieldError.checkNotNull(
                  isProfileComplete, r'UsersRecord', 'isProfileComplete'),
              name: name,
              coverPhotoUrl: coverPhotoUrl,
              gender: gender,
              birthday: birthday,
              hasPhoto: BuiltValueNullFieldError.checkNotNull(
                  hasPhoto, r'UsersRecord', 'hasPhoto'),
              lastPostCreatedAt: lastPostCreatedAt,
              lastPost: lastPost.build(),
              recentPosts: _recentPosts?.build(),
              isPremiumUser: isPremiumUser,
              noOfPosts: BuiltValueNullFieldError.checkNotNull(
                  noOfPosts, r'UsersRecord', 'noOfPosts'),
              noOfComments: BuiltValueNullFieldError.checkNotNull(
                  noOfComments, r'UsersRecord', 'noOfComments'),
              followings: followings.build(),
              referral: referral,
              referralAcceptedAt: referralAcceptedAt,
              stateMessage: stateMessage,
              favoriteChatRooms: favoriteChatRooms.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockedUsers';
        blockedUsers.build();

        _$failedField = 'lastPost';
        lastPost.build();
        _$failedField = 'recentPosts';
        _recentPosts?.build();

        _$failedField = 'followings';
        followings.build();

        _$failedField = 'favoriteChatRooms';
        favoriteChatRooms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UsersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
