import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  String? get email;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  String get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  DateTime get updatedAt;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  bool get admin;

  BuiltList<DocumentReference> get blockedUsers;

  bool get isProfileComplete;

  String? get name;

  String? get coverPhotoUrl;

  String? get gender;

  DateTime? get birthday;

  bool get hasPhoto;

  DateTime? get lastPostCreatedAt;

  RecentPostsStruct get lastPost;

  BuiltList<RecentPostsStruct> get recentPosts;

  bool? get isPremiumUser;

  int get noOfPosts;

  int get noOfComments;

  BuiltList<DocumentReference> get followings;

  DocumentReference? get referral;

  DateTime? get referralAcceptedAt;

  String? get stateMessage;

  BuiltList<DocumentReference> get favoriteChatRooms;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..displayName = ''
    ..uid = ''
    ..createdTime = DateTime(1970, 1, 1)
    ..updatedAt = DateTime(1970, 1, 1)
    ..admin = false
    ..blockedUsers = ListBuilder()
    ..isProfileComplete = false
    ..hasPhoto = false
    ..lastPost = RecentPostsStructBuilder()
    ..recentPosts = ListBuilder()
    ..noOfPosts = 0
    ..noOfComments = 0
    ..followings = ListBuilder()
    ..favoriteChatRooms = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  DateTime? updatedAt,
  String? phoneNumber,
  bool admin = false,
  bool isProfileComplete = false,
  String? name,
}) {
  final firestoreData = serializers.toFirestore(
    UsersRecord.serializer,
    UsersRecord(
      (u) => u
        ..email = email
        ..displayName = displayName
        ..photoUrl = photoUrl
        ..uid = uid
        ..createdTime = createdTime
        ..updatedAt = updatedAt
        ..phoneNumber = phoneNumber
        ..admin = admin
        ..blockedUsers = null
        ..isProfileComplete = isProfileComplete
        ..name = name
        ..favoriteChatRooms = null,
    ),
  );

  return firestoreData;
}
