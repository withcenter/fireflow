import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// UserSettingModel is a class that represents a user's setting.
///
class SettingService {
  static SettingService get instance =>
      _instance ?? (_instance = SettingService());
  static SettingService? _instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  DocumentReference get mySettingRef =>
      FirebaseFirestore.instance.collection('settings').doc(uid);
  DocumentReference get myUserDocumentReference =>
      FirebaseFirestore.instance.collection('users').doc(uid);

  User get my => FirebaseAuth.instance.currentUser!;

  /// Check user setting document exists.
  ///
  /// Returns true if the setting document exsits. otherwise, false.
  exists() async {
    final doc = await mySettingRef.get();
    return doc.exists;
  }

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
  Future<UserSettingModel> get() async {
    // get the user's data from the database
    final snapshot = await mySettingRef.get();
    return UserSettingModel.fromSnapshot(snapshot);
  }

  /// Creates /users_public_data/{uid} if it does not exist.
  /// This will crate /users_public_data/{uid} only if the user is logged in for the first time.
  generate() async {
    if (await exists()) {
      return;
    }

    await mySettingRef.set({
      'userDocumentReference': myUserDocumentReference,
    });

    dog('UserService.generateUserPublicData() - /settings/{Doc Reference(users)} created.');
  }
}
