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

  bool initialized = false;
  BuildContext? _context;
  BuildContext get context => _context!;

  late final FirebaseFirestore db;
  late final FirebaseAuth auth;
  CollectionReference get usersCol => db.collection('users');
  CollectionReference get systemSettingsCol => db.collection('system_settings');
  DocumentReference get keysRef => systemSettingsCol.doc('keys');
  Future<DocumentSnapshot> get getKeys => keysRef.get();

  late final KeyModel keys;

  /// Keep the login user's public data up to date.
  UserPublicDataModel? user;

  /// Current chat room reference.
  ///
  /// This is the current chat room that the user is in.
  /// This is used to determine whether to show the push notification from chat message or not.
  DocumentReference? currentChatRoomDocumentReference;

  /// AppService constructor
  ///
  /// AppService is a singleton. So, this constructor will be called only one time.
  /// The service initialization should be kept here.
  AppService() {
    dog("AppService.constructor() called.");
  }

  /// Initialize the AppService.
  ///
  /// AppService is a singleton and must be called at immediately after the app
  /// starts. You can call the init method multiple times to change the
  /// settings. But the initialization will be done only once.
  ///
  /// The [context] is the BuildContext of the root level screen. It must be
  /// valid and alive.
  ///
  /// The [debug] is to turn on/off the debug mode. It will print the logs in
  /// the dev console.
  ///
  ///
  /// This method must be called after the app boots and should be
  /// called on every root level screen with valid BuildContext. In other words,
  /// call this method again to put the valid/alive BuildContext of a screen.
  ///
  /// [context] is the BuildContext of a screen. It must be valid and alive.
  ///
  /// Set [debug] to true to print the logs in dev console.
  ///
  /// If [supabase] is set, AppService will sync the user, post, comment data
  /// into Supabase. So, the app can do FULLTEXT search and more complicated
  /// conditional search. Note that, the supabase must be initialized in the app
  /// before calling this method.
  ///
  /// If [messaging] is set, AppService will initialize the messaging service.
  /// See the API reference for details.
  /// will be no snackbar.
  ///
  ///
  void init({
    required BuildContext? context,
    bool debug = false,
    int noOfRecentPosts = 20,
    SupabaseOptions? supabase,
    MessagingOptions? messaging,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) {
    dog('AppService.instance.init()');
    _context = context;
    gDebug = debug;
    Config.instance.noOfRecentPosts = noOfRecentPosts;
    Config.instance.supabase = supabase;
    Config.instance.messaging = messaging;

    ///
    if (initialized == false) {
      dog("AppService.instance.init() - initializing...");

      /// Setup Firebase.
      ///
      /// This is the only place where Firebase is initialized.
      db = firestore ?? FirebaseFirestore.instance;
      this.auth = auth ?? FirebaseAuth.instance;

      ///
      initialized = true;
      _initSystemKeys();
      _initUser();
      MessagingService.instance.init();
    }
  }

  /// Initialize the user functions.
  ///
  /// This method must be called when the app is initialized.
  _initUser() {
    dog('AppService._initUser()');

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      // User singed in
      if (user != null) {
        dog('AppService._initUser() - user is logged in');

        await UserService.instance.generateUserPublicDataDocument();
        UserService.instance.listenUserPublicData();
        await UserSettingService.instance.generate();
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
