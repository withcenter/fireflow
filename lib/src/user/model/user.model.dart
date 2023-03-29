import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';

/// UserModel is a class that represents a user.
///
class UserModel {
  DocumentReference reference;
  String id;
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
  FeedModel? lastPost;
  List<FeedModel> recentPosts;

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
    required this.id,
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
      id: reference.id,
      uid: json['uid'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
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
      lastPost: json['lastPost'] == null
          ? null
          : FeedModel.fromJson(json['lastPost']),
      recentPosts: (json['recentPosts'] ?? [])
          .map<FeedModel>((e) => FeedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPremiumUser: json['isPremiumUser'] ?? false,
      noOfPosts: json['noOfPosts'] ?? 0,
      noOfComments: json['noOfComments'] ?? 0,
      followings: List<DocumentReference>.from(json['followings'] ?? []),
      referral: json['referral'],
      referralAcceptedAt: json['referralAcceptedAt'],
      stateMessage: json['stateMessage'] ?? '',
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      id: user.uid,
      email: user.email ?? '',
      phoneNumber: user.phoneNumber ?? '',
      name: '',
      displayName: '',
      createdTime: Timestamp.fromDate(DateTime(1973)),
      updatedAt: Timestamp.fromDate(DateTime(1973)),
      admin: false,
      blockedUsers: [],
      favoriteChatRooms: [],
      isProfileComplete: false,
      photoUrl: null,
      coverPhotoUrl: null,
      gender: '',
      birthday: null,
      hasPhoto: false,
      lastPostCreatedAt: null,
      lastPost: null,
      recentPosts: [],
      isPremiumUser: false,
      noOfPosts: 0,
      noOfComments: 0,
      followings: [],
      referral: null,
      referralAcceptedAt: null,
      stateMessage: '',
      reference: UserService.instance.doc(user.uid),
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl, reference: $reference, admin: $admin, blockedUsers: $blockedUsers, favoriteChatRooms: $favoriteChatRooms, isProfileComplete: $isProfileComplete, name: $name}';
  }
}
