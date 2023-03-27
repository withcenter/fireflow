import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';

/// UserSettingModel is a class that represents a user's setting.
///
class UserSettingService {
  static UserSettingService get instance =>
      _instance ?? (_instance = UserSettingService());
  static UserSettingService? _instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  CollectionReference get col =>
      FirebaseFirestore.instance.collection('user_settings');
  DocumentReference doc(String id) =>
      FirebaseFirestore.instance.collection('user_settings').doc(id);
  DocumentReference get ref =>
      FirebaseFirestore.instance.collection('user_settings').doc(uid);
  DocumentReference get myUserDocumentReference =>
      FirebaseFirestore.instance.collection('users').doc(uid);

  User get my => FirebaseAuth.instance.currentUser!;

  /// Check user setting document exists.
  ///
  /// Returns true if the setting document exsits. otherwise, false.
  exists() async {
    final doc = await ref.get();
    return doc.exists;
  }

  /// Warning, this method may throw an exception if it is being called immediately after the user is signed in for the first time.
  /// The `/users/{uid}` document may be created after the user is signed in.
  Future<UserSettingModel> get([String? id]) async {
    if (id == null) {
      return UserSettingModel.fromSnapshot(await ref.get());
    } else {
      return UserSettingModel.fromSnapshot(await doc(id).get());
    }
  }

  notifyNewComments(bool? value) async {
    await ref.update({
      'notifyNewComments': value ?? false,
    });
  }
}
