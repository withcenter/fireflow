import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String phoneNumber;
  String displayName;
  String photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
    required this.photoUrl,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      id: snapshot.id,
    );
  }

  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return UserModel(
      uid: json['uid'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }

  // create "toString()" method that returns a string of the object of this class
  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl}';
  }
}
