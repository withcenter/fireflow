import 'dart:async';

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

  StreamSubscription? publicDataSubscription;

  /// Keep the login user's public data up to date.
  UserPublicDataModel? user;

  Function(String, Map<String, String>)? onTapMessage;

  /// Current chat room reference.
  ///
  /// This is the current chat room that the user is in.
  /// This is used to determine whether to show the push notification from chat message or not.
  DocumentReference? currentChatRoomDocumentReference;

  AppService() {
    dog("AppService.constructor() called.");
    initSystemKeys();
    initUser();
    MessagingService.instance.init();
  }

  /// This method must be called when the app is initialized.
  /// Don't put any initialization here. Put initialization in the constructor, instead.
  void init({
    required BuildContext context,
    bool debug = false,
    Function(String, Map<String, dynamic>)? onTapMessage,
  }) {
    dog('AppService.instance.init()');
    this.context = context;
    gDebug = debug;
    if (onTapMessage != null) this.onTapMessage = onTapMessage;
  }

  /// Initialize the user functions.
  ///
  /// This method must be called when the app is initialized.
  initUser() {
    dog('AppService.initUser()');
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      // User singed in
      if (user != null) {
        dog('AppService.initUser() - user is logged in');

        ///
        await UserService.instance.generateUserPublicDataDocument();

        /// Get & update the user public data.
        publicDataSubscription?.cancel();
        publicDataSubscription =
            UserService.instance.myUserPublicDataRef.snapshots().listen((snapshot) {
          dog('AppService.initUser() - publicDataSubscription');
          if (snapshot.exists) {
            dog('AppService.initUser() - publicDataSubscription - snapshot.exists');
            this.user = UserPublicDataModel.fromSnapshot(snapshot);
            dog('AppService.initUser() - publicDataSubscription - publicData: ${this.user}');
          }
        });

        ///
        await SettingService.instance.generate();
      } else {
        this.user = null;
        dog('AppService.initUser() - user is not logged in');
      }
    });
  }

  initSystemKeys() async {
    keys = KeyModel.fromSnapshot(await getKeys);
  }
}
