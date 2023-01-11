import 'dart:developer';

import 'package:fireflow/fireflow.dart';

/// globa debug mode
///
/// If this is true, debug message will be printed.
/// Note that, it can't be inside AppService class. It will cause stack overflow.
bool gDebug = false;

/// This function is used to print debug message.
///
/// [message] is the message to print
dog(String message) {
  if (gDebug) log("DOG ---> $message");
}
