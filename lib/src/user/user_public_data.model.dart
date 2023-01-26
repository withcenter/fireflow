import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<DocumentReference> followers;
  bool hasPhoto;
  bool isProfileComplete;
  String coverPhotoUrl;
  List<Map<String, dynamic>> recentPosts;
  Timestamp lastPostCreatedAt;
  bool isPremiumUser;

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
    required this.followers,
    required this.hasPhoto,
    required this.isProfileComplete,
    required this.coverPhotoUrl,
    required this.recentPosts,
    required this.lastPostCreatedAt,
    required this.isPremiumUser,
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
    String? id,
  }) {
    return UserPublicDataModel(
      uid: json['uid'],
      userDocumentReference: json['userDocumentReference'],
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      registeredAt: json['registeredAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
      gender: json['gender'] ?? '',
      birthday: json['birthday'] ?? Timestamp.now(),
      followers: List<DocumentReference>.from(json['followers'] ?? []),
      hasPhoto: json['hasPhoto'] ?? false,
      isProfileComplete: json['isProfileComplete'] ?? false,
      coverPhotoUrl: json['coverPhotoUrl'] ?? '',
      recentPosts: List<Map<String, dynamic>>.from(json['recentPosts'] ?? []),
      lastPostCreatedAt: json['lastPostCreatedAt'] ?? Timestamp.now(),
      isPremiumUser: json['isPremiumUser'] ?? false,
      data: json,
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return "UserPublicDataModel(uid: $uid, userDocumentReference: $userDocumentReference, displayName: $displayName, photoUrl: $photoUrl, gender: $gender, registeredAt: $registeredAt, updatedAt: $updatedAt)";
  }
}
