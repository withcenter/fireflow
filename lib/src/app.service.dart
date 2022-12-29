import 'package:flutter/material.dart';

class AppService {
  // create a singleton method of AppService

  static AppService get instance => _instance ?? (_instance = AppService());
  static AppService? _instance;

  AppService() {
    // initialize your service here
    debugPrint('--> AppService()');
  }

  void init() {
    // initialize your service here
    debugPrint('--> AppService.init()');
  }

  int addOne(int value) {
    debugPrint('--> AppService.addOne($value) = ${value + 1}');
    return value + 1;
  }
}
