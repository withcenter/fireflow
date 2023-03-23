import 'package:fireflow/fireflow.dart';

/// UserModel is a class that represents a user.
///
class UserModel {
  String uid;
  String email;
  String phoneNumber;
  String displayName;
  String photoUrl;
  bool admin;
  List<DocumentReference> blockedUsers;
  List<DocumentReference> favoriteChatRooms;
  bool isProfileComplete;

  // [name] can be used to store the user's real name.
  String name;

  DocumentReference ref;

  /// UserModel constructor.
  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
    required this.photoUrl,
    required this.ref,
    required this.admin,
    required this.blockedUsers,
    required this.favoriteChatRooms,
    required this.isProfileComplete,
    required this.name,
  });

  /// Create a UserModel object from a snapshot of a document.
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  /// Create a UserModel object from a json object.
  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    return UserModel(
      uid: json['uid'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      ref: UserService.instance.doc(id),
      admin: json['admin'] ?? false,
      blockedUsers: List<DocumentReference>.from(json['blockedUsers'] ?? []),
      favoriteChatRooms:
          List<DocumentReference>.from(json['favoriteChatRooms'] ?? []),
      isProfileComplete: json['isProfileComplete'] ?? false,
      name: json['name'] ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl, ref: $ref, admin: $admin, blockedUsers: $blockedUsers, favoriteChatRooms: $favoriteChatRooms, isProfileComplete: $isProfileComplete, name: $name}';
  }
}
