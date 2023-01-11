import 'dart:developer';

import 'package:fireflow/fireflow.dart';

/// globa debug mode
///
/// If this is true, debug message will be printed.

/// This function is used to print debug message.
///
/// [message] is the message to print
dog(String message) {
  if (AppService.instance.debug) log("---> $message");
}
