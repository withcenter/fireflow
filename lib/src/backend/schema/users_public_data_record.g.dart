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
    value = object.chatMessageCount;
    if (value != null) {
      result
        ..add('chatMessageCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateSalary;
    if (value != null) {
      result
        ..add('certificateSalary')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateJob;
    if (value != null) {
      result
        ..add('certificateJob')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateSchool;
    if (value != null) {
      result
        ..add('certificateSchool')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCar1;
    if (value != null) {
      result
        ..add('certificateCar1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCar2;
    if (value != null) {
      result
        ..add('certificateCar2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCar1Year;
    if (value != null) {
      result
        ..add('certificateCar1Year')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCar2Year;
    if (value != null) {
      result
        ..add('certificateCar2Year')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCeleb;
    if (value != null) {
      result
        ..add('certificateCeleb')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.instagram;
    if (value != null) {
      result
        ..add('instagram')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mbti;
    if (value != null) {
      result
        ..add('mbti')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.job;
    if (value != null) {
      result
        ..add('job')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.openAge;
    if (value != null) {
      result
        ..add('openAge')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.certificateSalaryImageUrl;
    if (value != null) {
      result
        ..add('certificateSalaryImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateJobImageUrl;
    if (value != null) {
      result
        ..add('certificateJobImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateSchoolImageUrl;
    if (value != null) {
      result
        ..add('certificateSchoolImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCarImageUrl;
    if (value != null) {
      result
        ..add('certificateCarImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCelebImageUrl;
    if (value != null) {
      result
        ..add('certificateCelebImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.certificateCar2ImageUrl;
    if (value != null) {
      result
        ..add('certificateCar2ImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.area;
    if (value != null) {
      result
        ..add('area')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber2;
    if (value != null) {
      result
        ..add('phoneNumber2')
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
        case 'chatMessageCount':
          result.chatMessageCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateSalary':
          result.certificateSalary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateJob':
          result.certificateJob = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateSchool':
          result.certificateSchool = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCar1':
          result.certificateCar1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCar2':
          result.certificateCar2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCar1Year':
          result.certificateCar1Year = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCar2Year':
          result.certificateCar2Year = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCeleb':
          result.certificateCeleb = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'instagram':
          result.instagram = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mbti':
          result.mbti = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'job':
          result.job = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'openAge':
          result.openAge = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'certificateSalaryImageUrl':
          result.certificateSalaryImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateJobImageUrl':
          result.certificateJobImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateSchoolImageUrl':
          result.certificateSchoolImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCarImageUrl':
          result.certificateCarImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCelebImageUrl':
          result.certificateCelebImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'certificateCar2ImageUrl':
          result.certificateCar2ImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'area':
          result.area = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phoneNumber2':
          result.phoneNumber2 = serializers.deserialize(value,
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
  final int? chatMessageCount;
  @override
  final String? message;
  @override
  final String? certificateSalary;
  @override
  final String? certificateJob;
  @override
  final String? certificateSchool;
  @override
  final String? certificateCar1;
  @override
  final String? certificateCar2;
  @override
  final String? certificateCar1Year;
  @override
  final String? certificateCar2Year;
  @override
  final String? certificateCeleb;
  @override
  final String? instagram;
  @override
  final String? mbti;
  @override
  final String? job;
  @override
  final bool? openAge;
  @override
  final String? certificateSalaryImageUrl;
  @override
  final String? certificateJobImageUrl;
  @override
  final String? certificateSchoolImageUrl;
  @override
  final String? certificateCarImageUrl;
  @override
  final String? certificateCelebImageUrl;
  @override
  final String? certificateCar2ImageUrl;
  @override
  final String? area;
  @override
  final String? phoneNumber2;
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
      this.chatMessageCount,
      this.message,
      this.certificateSalary,
      this.certificateJob,
      this.certificateSchool,
      this.certificateCar1,
      this.certificateCar2,
      this.certificateCar1Year,
      this.certificateCar2Year,
      this.certificateCeleb,
      this.instagram,
      this.mbti,
      this.job,
      this.openAge,
      this.certificateSalaryImageUrl,
      this.certificateJobImageUrl,
      this.certificateSchoolImageUrl,
      this.certificateCarImageUrl,
      this.certificateCelebImageUrl,
      this.certificateCar2ImageUrl,
      this.area,
      this.phoneNumber2,
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
        chatMessageCount == other.chatMessageCount &&
        message == other.message &&
        certificateSalary == other.certificateSalary &&
        certificateJob == other.certificateJob &&
        certificateSchool == other.certificateSchool &&
        certificateCar1 == other.certificateCar1 &&
        certificateCar2 == other.certificateCar2 &&
        certificateCar1Year == other.certificateCar1Year &&
        certificateCar2Year == other.certificateCar2Year &&
        certificateCeleb == other.certificateCeleb &&
        instagram == other.instagram &&
        mbti == other.mbti &&
        job == other.job &&
        openAge == other.openAge &&
        certificateSalaryImageUrl == other.certificateSalaryImageUrl &&
        certificateJobImageUrl == other.certificateJobImageUrl &&
        certificateSchoolImageUrl == other.certificateSchoolImageUrl &&
        certificateCarImageUrl == other.certificateCarImageUrl &&
        certificateCelebImageUrl == other.certificateCelebImageUrl &&
        certificateCar2ImageUrl == other.certificateCar2ImageUrl &&
        area == other.area &&
        phoneNumber2 == other.phoneNumber2 &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, uid.hashCode), userDocumentReference.hashCode), registeredAt.hashCode), updatedAt.hashCode), displayName.hashCode), photoUrl.hashCode), coverPhotoUrl.hashCode), gender.hashCode), birthday.hashCode), hasPhoto.hashCode), isProfileComplete.hashCode), lastPostCreatedAt.hashCode), lastPost.hashCode), recentPosts.hashCode), isPremiumUser.hashCode), noOfPosts.hashCode), noOfComments.hashCode), followings.hashCode), referral.hashCode), referralAcceptedAt.hashCode), chatMessageCount.hashCode), message.hashCode), certificateSalary.hashCode), certificateJob.hashCode),
                                                                                certificateSchool.hashCode),
                                                                            certificateCar1.hashCode),
                                                                        certificateCar2.hashCode),
                                                                    certificateCar1Year.hashCode),
                                                                certificateCar2Year.hashCode),
                                                            certificateCeleb.hashCode),
                                                        instagram.hashCode),
                                                    mbti.hashCode),
                                                job.hashCode),
                                            openAge.hashCode),
                                        certificateSalaryImageUrl.hashCode),
                                    certificateJobImageUrl.hashCode),
                                certificateSchoolImageUrl.hashCode),
                            certificateCarImageUrl.hashCode),
                        certificateCelebImageUrl.hashCode),
                    certificateCar2ImageUrl.hashCode),
                area.hashCode),
            phoneNumber2.hashCode),
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
          ..add('chatMessageCount', chatMessageCount)
          ..add('message', message)
          ..add('certificateSalary', certificateSalary)
          ..add('certificateJob', certificateJob)
          ..add('certificateSchool', certificateSchool)
          ..add('certificateCar1', certificateCar1)
          ..add('certificateCar2', certificateCar2)
          ..add('certificateCar1Year', certificateCar1Year)
          ..add('certificateCar2Year', certificateCar2Year)
          ..add('certificateCeleb', certificateCeleb)
          ..add('instagram', instagram)
          ..add('mbti', mbti)
          ..add('job', job)
          ..add('openAge', openAge)
          ..add('certificateSalaryImageUrl', certificateSalaryImageUrl)
          ..add('certificateJobImageUrl', certificateJobImageUrl)
          ..add('certificateSchoolImageUrl', certificateSchoolImageUrl)
          ..add('certificateCarImageUrl', certificateCarImageUrl)
          ..add('certificateCelebImageUrl', certificateCelebImageUrl)
          ..add('certificateCar2ImageUrl', certificateCar2ImageUrl)
          ..add('area', area)
          ..add('phoneNumber2', phoneNumber2)
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

  int? _chatMessageCount;
  int? get chatMessageCount => _$this._chatMessageCount;
  set chatMessageCount(int? chatMessageCount) =>
      _$this._chatMessageCount = chatMessageCount;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _certificateSalary;
  String? get certificateSalary => _$this._certificateSalary;
  set certificateSalary(String? certificateSalary) =>
      _$this._certificateSalary = certificateSalary;

  String? _certificateJob;
  String? get certificateJob => _$this._certificateJob;
  set certificateJob(String? certificateJob) =>
      _$this._certificateJob = certificateJob;

  String? _certificateSchool;
  String? get certificateSchool => _$this._certificateSchool;
  set certificateSchool(String? certificateSchool) =>
      _$this._certificateSchool = certificateSchool;

  String? _certificateCar1;
  String? get certificateCar1 => _$this._certificateCar1;
  set certificateCar1(String? certificateCar1) =>
      _$this._certificateCar1 = certificateCar1;

  String? _certificateCar2;
  String? get certificateCar2 => _$this._certificateCar2;
  set certificateCar2(String? certificateCar2) =>
      _$this._certificateCar2 = certificateCar2;

  String? _certificateCar1Year;
  String? get certificateCar1Year => _$this._certificateCar1Year;
  set certificateCar1Year(String? certificateCar1Year) =>
      _$this._certificateCar1Year = certificateCar1Year;

  String? _certificateCar2Year;
  String? get certificateCar2Year => _$this._certificateCar2Year;
  set certificateCar2Year(String? certificateCar2Year) =>
      _$this._certificateCar2Year = certificateCar2Year;

  String? _certificateCeleb;
  String? get certificateCeleb => _$this._certificateCeleb;
  set certificateCeleb(String? certificateCeleb) =>
      _$this._certificateCeleb = certificateCeleb;

  String? _instagram;
  String? get instagram => _$this._instagram;
  set instagram(String? instagram) => _$this._instagram = instagram;

  String? _mbti;
  String? get mbti => _$this._mbti;
  set mbti(String? mbti) => _$this._mbti = mbti;

  String? _job;
  String? get job => _$this._job;
  set job(String? job) => _$this._job = job;

  bool? _openAge;
  bool? get openAge => _$this._openAge;
  set openAge(bool? openAge) => _$this._openAge = openAge;

  String? _certificateSalaryImageUrl;
  String? get certificateSalaryImageUrl => _$this._certificateSalaryImageUrl;
  set certificateSalaryImageUrl(String? certificateSalaryImageUrl) =>
      _$this._certificateSalaryImageUrl = certificateSalaryImageUrl;

  String? _certificateJobImageUrl;
  String? get certificateJobImageUrl => _$this._certificateJobImageUrl;
  set certificateJobImageUrl(String? certificateJobImageUrl) =>
      _$this._certificateJobImageUrl = certificateJobImageUrl;

  String? _certificateSchoolImageUrl;
  String? get certificateSchoolImageUrl => _$this._certificateSchoolImageUrl;
  set certificateSchoolImageUrl(String? certificateSchoolImageUrl) =>
      _$this._certificateSchoolImageUrl = certificateSchoolImageUrl;

  String? _certificateCarImageUrl;
  String? get certificateCarImageUrl => _$this._certificateCarImageUrl;
  set certificateCarImageUrl(String? certificateCarImageUrl) =>
      _$this._certificateCarImageUrl = certificateCarImageUrl;

  String? _certificateCelebImageUrl;
  String? get certificateCelebImageUrl => _$this._certificateCelebImageUrl;
  set certificateCelebImageUrl(String? certificateCelebImageUrl) =>
      _$this._certificateCelebImageUrl = certificateCelebImageUrl;

  String? _certificateCar2ImageUrl;
  String? get certificateCar2ImageUrl => _$this._certificateCar2ImageUrl;
  set certificateCar2ImageUrl(String? certificateCar2ImageUrl) =>
      _$this._certificateCar2ImageUrl = certificateCar2ImageUrl;

  String? _area;
  String? get area => _$this._area;
  set area(String? area) => _$this._area = area;

  String? _phoneNumber2;
  String? get phoneNumber2 => _$this._phoneNumber2;
  set phoneNumber2(String? phoneNumber2) => _$this._phoneNumber2 = phoneNumber2;

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
      _chatMessageCount = $v.chatMessageCount;
      _message = $v.message;
      _certificateSalary = $v.certificateSalary;
      _certificateJob = $v.certificateJob;
      _certificateSchool = $v.certificateSchool;
      _certificateCar1 = $v.certificateCar1;
      _certificateCar2 = $v.certificateCar2;
      _certificateCar1Year = $v.certificateCar1Year;
      _certificateCar2Year = $v.certificateCar2Year;
      _certificateCeleb = $v.certificateCeleb;
      _instagram = $v.instagram;
      _mbti = $v.mbti;
      _job = $v.job;
      _openAge = $v.openAge;
      _certificateSalaryImageUrl = $v.certificateSalaryImageUrl;
      _certificateJobImageUrl = $v.certificateJobImageUrl;
      _certificateSchoolImageUrl = $v.certificateSchoolImageUrl;
      _certificateCarImageUrl = $v.certificateCarImageUrl;
      _certificateCelebImageUrl = $v.certificateCelebImageUrl;
      _certificateCar2ImageUrl = $v.certificateCar2ImageUrl;
      _area = $v.area;
      _phoneNumber2 = $v.phoneNumber2;
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
              chatMessageCount: chatMessageCount,
              message: message,
              certificateSalary: certificateSalary,
              certificateJob: certificateJob,
              certificateSchool: certificateSchool,
              certificateCar1: certificateCar1,
              certificateCar2: certificateCar2,
              certificateCar1Year: certificateCar1Year,
              certificateCar2Year: certificateCar2Year,
              certificateCeleb: certificateCeleb,
              instagram: instagram,
              mbti: mbti,
              job: job,
              openAge: openAge,
              certificateSalaryImageUrl: certificateSalaryImageUrl,
              certificateJobImageUrl: certificateJobImageUrl,
              certificateSchoolImageUrl: certificateSchoolImageUrl,
              certificateCarImageUrl: certificateCarImageUrl,
              certificateCelebImageUrl: certificateCelebImageUrl,
              certificateCar2ImageUrl: certificateCar2ImageUrl,
              area: area,
              phoneNumber2: phoneNumber2,
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
