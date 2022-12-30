import 'dart:developer';

bool globalDebugMode = false;
dog(String message) {
  if (globalDebugMode) log("---> $message");
}
