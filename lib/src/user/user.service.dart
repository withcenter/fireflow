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

  User get my => FirebaseAuth.instance.currentUser!;

  userPublicDataDocumentExists() async {
    final doc = await myUserPublicDataRef.get();
    return doc.exists;
  }

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
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
  generateUserPublicDataDocument() async {
    if (await userPublicDataDocumentExists()) {
      return;
    }

    await myUserPublicDataRef.set({
      'displayName': my.displayName ?? '',
      'photoUrl': my.photoURL ?? '',
      'uid': uid,
      'userDocumentReference': myUserRef,
      'registeredAt': FieldValue.serverTimestamp(),
    });

    debugPrint(
        '--> UserService.generateUserPublicData() - user public data created.');
  }
}
