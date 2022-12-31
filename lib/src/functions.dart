import 'dart:developer';

/// globa debug mode
///
/// If this is true, debug message will be printed.
bool globalDebugMode = false;

/// This function is used to print debug message.
///
/// [message] is the message to print
dog(String message) {
  if (globalDebugMode) log("---> $message");
}
