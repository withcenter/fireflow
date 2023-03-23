import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_public_data_record.g.dart';

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

  int? get chatMessageCount;

  String? get statusMessage;

  String? get instagram;

  String? get job;

  bool? get openAge;

  String? get certificateSalaryImageUrl;

  String? get certificateJobImageUrl;

  String? get certificateSchoolImageUrl;

  String? get certificateCarImageUrl;

  String? get certificateCelebImageUrl;

  String? get certificateCar2ImageUrl;

  String? get area;

  String? get phoneNumber2;

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
        ..chatMessageCount = 0
        ..message = ''
        ..certificateSalary = ''
        ..certificateJob = ''
        ..certificateSchool = ''
        ..certificateCar1 = ''
        ..certificateCar2 = ''
        ..certificateCar1Year = ''
        ..certificateCar2Year = ''
        ..certificateCeleb = ''
        ..instagram = ''
        ..mbti = ''
        ..job = ''
        ..openAge = false
        ..certificateSalaryImageUrl = ''
        ..certificateJobImageUrl = ''
        ..certificateSchoolImageUrl = ''
        ..certificateCarImageUrl = ''
        ..certificateCelebImageUrl = ''
        ..certificateCar2ImageUrl = ''
        ..area = ''
        ..phoneNumber2 = '';

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
  int? chatMessageCount,
  String? message,
  String? certificateSalary,
  String? certificateJob,
  String? certificateSchool,
  String? certificateCar1,
  String? certificateCar2,
  String? certificateCar1Year,
  String? certificateCar2Year,
  String? certificateCeleb,
  String? instagram,
  String? mbti,
  String? job,
  bool? openAge,
  String? certificateSalaryImageUrl,
  String? certificateJobImageUrl,
  String? certificateSchoolImageUrl,
  String? certificateCarImageUrl,
  String? certificateCelebImageUrl,
  String? certificateCar2ImageUrl,
  String? area,
  String? phoneNumber2,
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
        ..chatMessageCount = chatMessageCount
        ..message = message
        ..certificateSalary = certificateSalary
        ..certificateJob = certificateJob
        ..certificateSchool = certificateSchool
        ..certificateCar1 = certificateCar1
        ..certificateCar2 = certificateCar2
        ..certificateCar1Year = certificateCar1Year
        ..certificateCar2Year = certificateCar2Year
        ..certificateCeleb = certificateCeleb
        ..instagram = instagram
        ..mbti = mbti
        ..job = job
        ..openAge = openAge
        ..certificateSalaryImageUrl = certificateSalaryImageUrl
        ..certificateJobImageUrl = certificateJobImageUrl
        ..certificateSchoolImageUrl = certificateSchoolImageUrl
        ..certificateCarImageUrl = certificateCarImageUrl
        ..certificateCelebImageUrl = certificateCelebImageUrl
        ..certificateCar2ImageUrl = certificateCar2ImageUrl
        ..area = area
        ..phoneNumber2 = phoneNumber2,
    ),
  );

  // Handle nested data for "lastPost" field.
  addRecentPostsStructData(firestoreData, lastPost, 'lastPost');

  return firestoreData;
}
