import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class AppService {
  // create a singleton method of AppService

  static AppService get instance => _instance ?? (_instance = AppService());
  static AppService? _instance;
  late final BuildContext context;

  AppService() {
    // initialize your service here
    debugPrint('--> AppService()');
    initUser();
  }

  /// This method must be called when the app is initialized.
  void init({
    required BuildContext context,
  }) {
    debugPrint('--> AppService.instance.init()');
    this.context = context;
  }

  initUser() {
    debugPrint('--> AppService.initUser()');
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        debugPrint('--> AppService.initUser() - user is logged in');

        /// Don't do async/await here.
        UserService.instance.generateUserPublicDataDocument();
        SettingService.instance.generate();
      } else {
        debugPrint('--> AppService.initUser() - user is not logged in');
      }
    });
  }
}
