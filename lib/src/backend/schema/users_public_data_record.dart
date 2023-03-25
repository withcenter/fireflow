import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_public_data_record.g.dart';

@Deprecated('Use UsersRecord instead')
abstract class UsersPublicDataRecord
    implements Built<UsersPublicDataRecord, UsersPublicDataRecordBuilder> {
  static Serializer<UsersPublicDataRecord> get serializer =>
      _$usersPublicDataRecordSerializer;

  String? get uid;

  DocumentReference? get userDocumentReference;

  DateTime? get registeredAt;

  DateTime? get updatedAt;

  String? get displayName;

  String? get photoUrl;

  String? get coverPhotoUrl;

  String? get gender;

  DateTime? get birthday;

  bool? get hasPhoto;

  bool? get isProfileComplete;

  DateTime? get lastPostCreatedAt;

  RecentPostsStruct get lastPost;

  BuiltList<RecentPostsStruct>? get recentPosts;

  bool? get isPremiumUser;

  int? get noOfPosts;

  int? get noOfComments;

  BuiltList<DocumentReference>? get followings;

  DocumentReference? get referral;

  DateTime? get referralAcceptedAt;

  String? get stateMessage;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UsersPublicDataRecordBuilder builder) =>
      builder
        ..uid = ''
        ..displayName = ''
        ..photoUrl = ''
        ..coverPhotoUrl = ''
        ..gender = ''
        ..hasPhoto = false
        ..isProfileComplete = false
        ..lastPost = RecentPostsStructBuilder()
        ..recentPosts = ListBuilder()
        ..isPremiumUser = false
        ..noOfPosts = 0
        ..noOfComments = 0
        ..followings = ListBuilder()
        ..stateMessage = ''
        ..registeredAt = DateTime(1970, 1, 1)
        ..updatedAt = DateTime(1970, 1, 1);

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users_public_data');

  static Stream<UsersPublicDataRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UsersPublicDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UsersPublicDataRecord._();
  factory UsersPublicDataRecord(
          [void Function(UsersPublicDataRecordBuilder) updates]) =
      _$UsersPublicDataRecord;

  static UsersPublicDataRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersPublicDataRecordData({
  String? uid,
  DocumentReference? userDocumentReference,
  DateTime? registeredAt,
  DateTime? updatedAt,
  String? displayName,
  String? photoUrl,
  String? coverPhotoUrl,
  String? gender,
  DateTime? birthday,
  bool? hasPhoto,
  bool? isProfileComplete,
  DateTime? lastPostCreatedAt,
  RecentPostsStruct? lastPost,
  bool? isPremiumUser,
  int? noOfPosts,
  int? noOfComments,
  DocumentReference? referral,
  DateTime? referralAcceptedAt,
  String? stateMessage,
}) {
  final firestoreData = serializers.toFirestore(
    UsersPublicDataRecord.serializer,
    UsersPublicDataRecord(
      (u) => u
        ..uid = uid
        ..userDocumentReference = userDocumentReference
        ..registeredAt = registeredAt
        ..updatedAt = updatedAt
        ..displayName = displayName
        ..photoUrl = photoUrl
        ..coverPhotoUrl = coverPhotoUrl
        ..gender = gender
        ..birthday = birthday
        ..hasPhoto = hasPhoto
        ..isProfileComplete = isProfileComplete
        ..lastPostCreatedAt = lastPostCreatedAt
        ..lastPost = RecentPostsStructBuilder()
        ..recentPosts = null
        ..isPremiumUser = isPremiumUser
        ..noOfPosts = noOfPosts
        ..noOfComments = noOfComments
        ..followings = null
        ..referral = referral
        ..referralAcceptedAt = referralAcceptedAt
        ..stateMessage = stateMessage,
    ),
  );

  // Handle nested data for "lastPost" field.
  addRecentPostsStructData(firestoreData, lastPost, 'lastPost');

  return firestoreData;
}
