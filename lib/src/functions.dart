import 'dart:developer';

bool globalDebug = false;
dog(String message) {
  if (globalDebug) log("---> $message");
}
