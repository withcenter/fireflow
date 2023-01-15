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

  /// Keep the login user's public data up to date.
  UserPublicDataModel? user;

  Function(String, Map<String, String>)? onTapMessage;

  /// Current chat room reference.
  ///
  /// This is the current chat room that the user is in.
  /// This is used to determine whether to show the push notification from chat message or not.
  DocumentReference? currentChatRoomDocumentReference;

  /// If [supabase] is set to true, then fireflow will interact with Supabase.
  late final bool supabase;

  /// AppService constructor
  ///
  /// AppService is a singleton. So, this constructor will be called only one time.
  /// The service initialization should be kept here.
  AppService() {
    dog("AppService.constructor() called.");
    _initSystemKeys();
    _initUser();
    MessagingService.instance.init();
  }

  /// Initialize the settings of AppService.
  ///
  /// This method must be called after the app boots and should be
  /// called on every root level screen with valid BuildContext. In other words,
  /// call this method again to put the valid/alive BuildContext of a screen.
  ///
  /// [context] is the BuildContext of a screen. It must be valid and alive.
  /// Set [debug] to true to print the logs in dev console.
  /// If [supabase] is set to true, AppService will sync the user, post, comment
  /// into Supabase. So, the app can do FULLTEXT search and more complicated
  /// conditional search.
  /// [onTapMessage] is a callback method and is called when the user taps on
  /// foreground push notification snackbar. If this is set to null, then there
  /// will be no snackbar.
  void init({
    required BuildContext context,
    bool debug = false,
    bool supabase = false,
    Function(String, Map<String, dynamic>)? onTapMessage,
  }) {
    dog('AppService.instance.init()');
    this.context = context;
    gDebug = debug;
    this.supabase = supabase;
    if (onTapMessage != null) this.onTapMessage = onTapMessage;
  }

  /// Initialize the user functions.
  ///
  /// This method must be called when the app is initialized.
  _initUser() {
    dog('AppService._initUser()');

    /// TODO - Use `distinct` to reduce the multiple event handling.
    /// TODO - FirebaseAuth.instance.authStateChanges().distinct((p, c) => p?.user?.uid == c?.user?.uid)
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      // User singed in
      if (user != null) {
        dog('AppService._initUser() - user is logged in');

        await UserService.instance.generateUserPublicDataDocument();
        UserService.instance.listenUserPublicData();
        await SettingService.instance.generate();
      } else {
        this.user = null;
        dog('AppService._initUser() - user is not logged in');
      }
    });
  }

  /// Get keys from Firestore.
  _initSystemKeys() async {
    keys = KeyModel.fromSnapshot(await getKeys);
  }
}
