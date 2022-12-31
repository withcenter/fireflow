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
  late final BuildContext context;

  /// Current chat room reference.
  ///
  /// This is the current chat room that the user is in.
  /// This is used to determine whether to show the push notification from chat message or not.
  DocumentReference? currentChatRoomReference;

  AppService() {
    dog("AppService.constructor() called.");
    initUser();
  }

  /// This method must be called when the app is initialized.
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
}
