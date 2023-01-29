import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';

/// UserModel is a class that represents a document of /users_public_data.
///
class UserPublicDataModel {
  String uid;
  DocumentReference userDocumentReference;
  String displayName;
  String photoUrl;
  Timestamp registeredAt;
  Timestamp updatedAt;
  String gender;
  Timestamp birthday;
  // List<DocumentReference> followers;
  bool hasPhoto;
  bool isProfileComplete;
  String coverPhotoUrl;
  UserPublicDataRecentPostModel? lastPost;
  List<UserPublicDataRecentPostModel>? recentPosts;
  Timestamp lastPostCreatedAt;
  bool isPremiumUser;
  List<DocumentReference> followings;

  Map<String, dynamic> data;

  UserPublicDataModel({
    required this.uid,
    required this.userDocumentReference,
    required this.displayName,
    required this.photoUrl,
    required this.registeredAt,
    required this.updatedAt,
    required this.gender,
    required this.birthday,
    // required this.followers,
    required this.hasPhoto,
    required this.isProfileComplete,
    required this.coverPhotoUrl,
    required this.lastPost,
    required this.recentPosts,
    required this.lastPostCreatedAt,
    required this.isPremiumUser,
    required this.followings,
    required this.data,
  });

  /// Create a UserPublicDataModel object from a snapshot of a document.
  factory UserPublicDataModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserPublicDataModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a UserPublicDataModel object from a json object.
  factory UserPublicDataModel.fromJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    return UserPublicDataModel(
      uid: json['uid'],
      // userDocumentReference may not be set for some cases like in unit tests.
      userDocumentReference: json['userDocumentReference'] ?? UserService.instance.doc(id),
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      registeredAt: json['registeredAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
      gender: json['gender'] ?? '',
      birthday: json['birthday'] ?? Timestamp.now(),
      // followers: List<DocumentReference>.from(json['followers'] ?? []),
      hasPhoto: json['hasPhoto'] ?? false,
      isProfileComplete: json['isProfileComplete'] ?? false,
      coverPhotoUrl: json['coverPhotoUrl'] ?? '',
      lastPost: json['lastPost'] != null ? UserPublicDataRecentPostModel.fromJson(json['lastPost']) : null,
      recentPosts: json['recentPosts'] != null ? (json['recentPosts'] as List).map((e) => UserPublicDataRecentPostModel.fromJson(e)).toList() : null,
      lastPostCreatedAt: json['lastPostCreatedAt'] ?? Timestamp.now(),
      isPremiumUser: json['isPremiumUser'] ?? false,
      followings: List<DocumentReference>.from(json['followings'] ?? []),
      data: json,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return "UserPublicDataModel(uid: $uid, userDocumentReference: $userDocumentReference, displayName: $displayName, photoUrl: $photoUrl, gender: $gender, registeredAt: $registeredAt, updatedAt: $updatedAt, birthday: $birthday, hasPhoto: $hasPhoto, isProfileComplete: $isProfileComplete, coverPhotoUrl: $coverPhotoUrl, recentPosts: $recentPosts, lastPostCreatedAt: $lastPostCreatedAt, isPremiumUser: $isPremiumUser, followings: $followings, data: $data)";
  }
}

class UserPublicDataRecentPostModel {
  final DocumentReference postDocumentReference;
  final String title;
  final String content;
  final String? photoUrl;
  final Timestamp createdAt;

  UserPublicDataRecentPostModel({
    required this.postDocumentReference,
    required this.title,
    required this.content,
    required this.photoUrl,
    required this.createdAt,
  });

  factory UserPublicDataRecentPostModel.fromJson(Map<String, dynamic> json) {
    return UserPublicDataRecentPostModel(
      postDocumentReference: json['postDocumentReference'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'postDocumentReference': postDocumentReference,
      'title': title,
      'content': content,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return "UserPublicDataRecentPostModel(postDocumentReference: $postDocumentReference, title: $title, content: $content, photoUrl: $photoUrl, createdAt: $createdAt)";
  }
}
