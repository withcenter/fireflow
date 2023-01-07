import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

/// AppService is a singleton class that provides necessary service for Fireflow.
///
class AppService {
  // create a singleton method of AppService

  static AppService get instance => _instance ?? (_instance = AppService());
  static AppService? _instance;
  late BuildContext context;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference get usersCol => db.collection('users');
  CollectionReference get systemSettingsCol => db.collection('system_settings');
  DocumentReference get keysRef => systemSettingsCol.doc('keys');
  Future<DocumentSnapshot> get getKeys => keysRef.get();

  late final KeyModel keys;

  /// Current chat room reference.
  ///
  /// This is the current chat room that the user is in.
  /// This is used to determine whether to show the push notification from chat message or not.
  DocumentReference? currentChatRoomReference;

  AppService() {
    dog("AppService.constructor() called.");
    initSystemKeys();
    initUser();
  }

  /// This method must be called when the app is initialized.
  /// Don't put any initialization here. Put initialization in the constructor, instead.
  void init({
    required BuildContext context,
    bool debug = false,
  }) {
    this.context = context;
    globalDebugMode = debug;
    dog('AppService.instance.init()');
  }

  /// Initialize the user functions.
  ///
  /// This method must be called when the app is initialized.
  initUser() {
    dog('AppService.initUser()');
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        dog('AppService.initUser() - user is logged in');

        /// Don't do async/await here.
        UserService.instance.generateUserPublicDataDocument();
        SettingService.instance.generate();
      } else {
        dog('AppService.initUser() - user is not logged in');
      }
    });
  }

  initSystemKeys() async {
    keys = KeyModel.fromSnapshot(await getKeys);
    print(keys);
  }
}
