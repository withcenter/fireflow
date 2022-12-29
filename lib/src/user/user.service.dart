import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class UserService {
  // create a singleton method of UserService
  static UserService get instance => _instance ?? (_instance = UserService());
  static UserService? _instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  DocumentReference get myUserRef =>
      FirebaseFirestore.instance.collection('users').doc(uid);
  DocumentReference get myUserPublicDataRef =>
      FirebaseFirestore.instance.collection('users_public_data').doc(uid);

  userPublicDataExists() async {
    final doc = await myUserPublicDataRef.get();
    return doc.exists;
  }

  Future<UserModel> getUser() async {
    // get the user's data from the database
    final snapshot = await myUserRef.get();
    return UserModel.fromSnapshot(snapshot);
  }

  Future<UserPublicDataModel> getUserPublicData() async {
    // get the user's public data from the database
    final snapshot = await myUserPublicDataRef.get();
    return UserPublicDataModel.fromSnapshot(snapshot);
  }

  /// Creates /users_public_data/{uid} if it does not exist.
  /// This will crate /users_public_data/{uid} only if the user is logged in for the first time.
  generateUserPublicData() async {
    if (await userPublicDataExists()) {
      return;
    }
    final user = await getUser();
    await myUserPublicDataRef.set({
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'uid': uid,
      'userDocumentReference': myUserRef,
    });

    debugPrint(
        '--> UserService.generateUserPublicData() - user public data created.');
  }
}
