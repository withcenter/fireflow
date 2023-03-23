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
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'photo_url',
      serializers.serialize(object.photoUrl,
          specifiedType: const FullType(String)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'created_time',
      serializers.serialize(object.createdTime,
          specifiedType: const FullType(DateTime)),
      'phone_number',
      serializers.serialize(object.phoneNumber,
          specifiedType: const FullType(String)),
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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.userPublicDataDocumentReference;
    if (value != null) {
      result
        ..add('userPublicDataDocumentReference')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.favoriteChatRooms;
    if (value != null) {
      result
        ..add('favoriteChatRooms')
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
              specifiedType: const FullType(String))! as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
        case 'userPublicDataDocumentReference':
          result.userPublicDataDocumentReference = serializers.deserialize(
              value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'isProfileComplete':
          result.isProfileComplete = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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
  final String email;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String uid;
  @override
  final DateTime createdTime;
  @override
  final String phoneNumber;
  @override
  final bool admin;
  @override
  final BuiltList<DocumentReference<Object?>> blockedUsers;
  @override
  final DocumentReference<Object?>? userPublicDataDocumentReference;
  @override
  final bool isProfileComplete;
  @override
  final String name;
  @override
  final BuiltList<DocumentReference<Object?>>? favoriteChatRooms;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UsersRecord([void Function(UsersRecordBuilder)? updates]) =>
      (new UsersRecordBuilder()..update(updates))._build();

  _$UsersRecord._(
      {required this.email,
      required this.displayName,
      required this.photoUrl,
      required this.uid,
      required this.createdTime,
      required this.phoneNumber,
      required this.admin,
      required this.blockedUsers,
      this.userPublicDataDocumentReference,
      required this.isProfileComplete,
      required this.name,
      this.favoriteChatRooms,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'UsersRecord', 'email');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'UsersRecord', 'displayName');
    BuiltValueNullFieldError.checkNotNull(photoUrl, r'UsersRecord', 'photoUrl');
    BuiltValueNullFieldError.checkNotNull(uid, r'UsersRecord', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        createdTime, r'UsersRecord', 'createdTime');
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'UsersRecord', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(admin, r'UsersRecord', 'admin');
    BuiltValueNullFieldError.checkNotNull(
        blockedUsers, r'UsersRecord', 'blockedUsers');
    BuiltValueNullFieldError.checkNotNull(
        isProfileComplete, r'UsersRecord', 'isProfileComplete');
    BuiltValueNullFieldError.checkNotNull(name, r'UsersRecord', 'name');
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
        phoneNumber == other.phoneNumber &&
        admin == other.admin &&
        blockedUsers == other.blockedUsers &&
        userPublicDataDocumentReference ==
            other.userPublicDataDocumentReference &&
        isProfileComplete == other.isProfileComplete &&
        name == other.name &&
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
                                                $jc($jc(0, email.hashCode),
                                                    displayName.hashCode),
                                                photoUrl.hashCode),
                                            uid.hashCode),
                                        createdTime.hashCode),
                                    phoneNumber.hashCode),
                                admin.hashCode),
                            blockedUsers.hashCode),
                        userPublicDataDocumentReference.hashCode),
                    isProfileComplete.hashCode),
                name.hashCode),
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
          ..add('phoneNumber', phoneNumber)
          ..add('admin', admin)
          ..add('blockedUsers', blockedUsers)
          ..add('userPublicDataDocumentReference',
              userPublicDataDocumentReference)
          ..add('isProfileComplete', isProfileComplete)
          ..add('name', name)
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

  DocumentReference<Object?>? _userPublicDataDocumentReference;
  DocumentReference<Object?>? get userPublicDataDocumentReference =>
      _$this._userPublicDataDocumentReference;
  set userPublicDataDocumentReference(
          DocumentReference<Object?>? userPublicDataDocumentReference) =>
      _$this._userPublicDataDocumentReference = userPublicDataDocumentReference;

  bool? _isProfileComplete;
  bool? get isProfileComplete => _$this._isProfileComplete;
  set isProfileComplete(bool? isProfileComplete) =>
      _$this._isProfileComplete = isProfileComplete;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

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
      _phoneNumber = $v.phoneNumber;
      _admin = $v.admin;
      _blockedUsers = $v.blockedUsers.toBuilder();
      _userPublicDataDocumentReference = $v.userPublicDataDocumentReference;
      _isProfileComplete = $v.isProfileComplete;
      _name = $v.name;
      _favoriteChatRooms = $v.favoriteChatRooms?.toBuilder();
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
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'UsersRecord', 'email'),
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'UsersRecord', 'displayName'),
              photoUrl: BuiltValueNullFieldError.checkNotNull(
                  photoUrl, r'UsersRecord', 'photoUrl'),
              uid: BuiltValueNullFieldError.checkNotNull(
                  uid, r'UsersRecord', 'uid'),
              createdTime: BuiltValueNullFieldError.checkNotNull(
                  createdTime, r'UsersRecord', 'createdTime'),
              phoneNumber: BuiltValueNullFieldError.checkNotNull(
                  phoneNumber, r'UsersRecord', 'phoneNumber'),
              admin: BuiltValueNullFieldError.checkNotNull(
                  admin, r'UsersRecord', 'admin'),
              blockedUsers: blockedUsers.build(),
              userPublicDataDocumentReference: userPublicDataDocumentReference,
              isProfileComplete: BuiltValueNullFieldError.checkNotNull(
                  isProfileComplete, r'UsersRecord', 'isProfileComplete'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'UsersRecord', 'name'),
              favoriteChatRooms: _favoriteChatRooms?.build(),
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockedUsers';
        blockedUsers.build();

        _$failedField = 'favoriteChatRooms';
        _favoriteChatRooms?.build();
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
