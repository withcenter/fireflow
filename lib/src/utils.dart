import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

DateTime? tryDateTime(dynamic value) {
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  return null;
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

/// 예/아니오 창을 띄운다.
///
Future<bool?> confirm(BuildContext context, String title, String message) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
