import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class AppService {
  // create a singleton method of AppService

  static AppService get instance => _instance ?? (_instance = AppService());
  static AppService? _instance;

  AppService() {
    // initialize your service here
    debugPrint('--> AppService()');
    initUser();
  }

  /// This method must be called when the app is initialized.
  void init() {
    debugPrint('--> AppService.instance.init()');
  }

  initUser() {
    debugPrint('--> AppService.initUser()');
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        debugPrint('--> AppService.initUser() - user is logged in');
        UserService.instance.generateUserPublicData();
      } else {
        debugPrint('--> AppService.initUser() - user is not logged in');
      }
    });
  }
}
