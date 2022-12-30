import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class AppService {
  // create a singleton method of AppService

  static AppService get instance => _instance ?? (_instance = AppService());
  static AppService? _instance;
  late final BuildContext context;

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
    globalDebug = debug;
    dog('AppService.instance.init()');
  }

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
