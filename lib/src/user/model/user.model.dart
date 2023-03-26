import 'package:cloud_firestore/cloud_firestore.dart';

/// UserModel is a class that represents a user.
///
class UserModel {
  DocumentReference reference;
  String uid;
  String email;
  String phoneNumber;

  // 별명
  String displayName;
  // 본명을 기록 할 때 사용.
  String name;

  Timestamp createdTime;
  Timestamp? updatedAt;
  bool admin;
  List<DocumentReference> blockedUsers;
  List<DocumentReference> favoriteChatRooms;
  bool isProfileComplete;

  // 프로필 사진.
  String? photoUrl;

  // 커버 사진, 타이틀 사진..
  String? coverPhotoUrl;

  // 성별. M 또는 F.
  String gender;

  // 생일.
  Timestamp? birthday;

  bool hasPhoto;

  Timestamp? lastPostCreatedAt;
  Map<String, dynamic> lastPost;
  List<Map<String, dynamic>> recentPosts;

  bool isPremiumUser;
  int noOfPosts;
  int noOfComments;
  List<DocumentReference> followings;
  DocumentReference? referral;
  Timestamp? referralAcceptedAt;
  String stateMessage;

  /// UserModel constructor.
  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.displayName,
    required this.createdTime,
    required this.updatedAt,
    required this.admin,
    required this.blockedUsers,
    required this.favoriteChatRooms,
    required this.isProfileComplete,
    required this.photoUrl,
    required this.coverPhotoUrl,
    required this.gender,
    required this.birthday,
    required this.hasPhoto,
    required this.lastPostCreatedAt,
    required this.lastPost,
    required this.recentPosts,
    required this.isPremiumUser,
    required this.noOfPosts,
    required this.noOfComments,
    required this.followings,
    required this.referral,
    required this.referralAcceptedAt,
    required this.stateMessage,
    required this.reference,
  });

  /// Create a UserModel object from a snapshot of a document.
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      reference: snapshot.reference,
    );
  }

  /// Create a UserModel object from a json object.
  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    required DocumentReference reference,
  }) {
    return UserModel(
      reference: reference,
      uid: json['uid'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      name: json['name'] ?? '',
      displayName: json['displayName'] ?? '',
      createdTime:
          json['created_time'] ?? Timestamp.fromDate(DateTime(1973, 1, 1)),
      updatedAt: json['updatedAt'] ?? Timestamp.fromDate(DateTime(1973, 1, 1)),
      admin: json['admin'] ?? false,
      blockedUsers: List<DocumentReference>.from(json['blockedUsers'] ?? []),
      favoriteChatRooms:
          List<DocumentReference>.from(json['favoriteChatRooms'] ?? []),
      isProfileComplete: json['isProfileComplete'] ?? false,
      photoUrl: json['photo_url'],
      coverPhotoUrl: json['coverPhotoUrl'],
      gender: json['gender'] ?? '',
      birthday: json['birthday'],
      hasPhoto: json['hasPhoto'] ?? false,
      lastPostCreatedAt: json['lastPostCreatedAt'],
      lastPost: json['lastPost'] ?? {},
      recentPosts: List<Map<String, dynamic>>.from(json['recentPosts'] ?? []),
      isPremiumUser: json['isPremiumUser'] ?? false,
      noOfPosts: json['noOfPosts'] ?? 0,
      noOfComments: json['noOfComments'] ?? 0,
      followings: List<DocumentReference>.from(json['followings'] ?? []),
      referral: json['referral'],
      referralAcceptedAt: json['referralAcceptedAt'],
      stateMessage: json['stateMessage'] ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl, reference: $reference, admin: $admin, blockedUsers: $blockedUsers, favoriteChatRooms: $favoriteChatRooms, isProfileComplete: $isProfileComplete, name: $name}';
  }
}
