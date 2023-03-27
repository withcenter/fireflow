import 'dart:developer';

import 'package:flutter/material.dart';

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

warning(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("WARNING: $message",
          style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red.shade900,
    ),
  );
}

success(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("SUCCESS: $message",
          style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color.fromARGB(255, 27, 114, 220),
    ),
  );
}
