import 'dart:developer' as d;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// globa debug mode
///
/// If this is true, debug message will be printed.
/// Note that, it can't be inside AppService class. It will cause stack overflow.
bool gDebug = false;

enum Collections {
  users,
  posts,
  comments,
}

/// This function is used to print debug message.
///
/// [message] is the message to print
dog(String message) {
  if (gDebug) d.log("DOG ---> $message");
}

DateTime? tryDateTime(dynamic value) {
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  return null;
}

warning(BuildContext context, String message) {
  if (context.mounted == false) return;
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

/// 문자열 유틸리티
extension FireFlowStringUtility on String {
  /// int 형으로 변환 시도. 실패하면 0을 반환한다.
  int tryInt() {
    return int.tryParse(this) ?? 0;
  }

  /// double 형으로 변환 시도. 실패하면 0을 반환한다.
  double tryDouble() {
    return double.tryParse(this) ?? 0;
  }

  /// 문자열을 각종 상황에서 안전하게 반환한다.
  /// 예를 들면, 여러 줄의 문자열을 한 줄로 만들거나, HTML 태그를 제거한다.
  /// 기본 길이는 128자로 제한한다.
  String get safe {
    return replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r"\s+"), " ")
        .substring(0, min(length, 128));
  }

  /// 안전한 문자열 32 글자로 리턴한다.
  String get safe32 {
    return safe.cut32;
  }

  /// 안전한 문자열 64 글자로 리턴한다.
  String get safe64 {
    return safe.cut64;
  }

  /// 문자열을 32자 이하로 자른다.
  String get cut32 {
    return substring(0, min(length, 32));
  }

  /// 문자열을 64자 이하로 자른다.
  String get cut64 {
    return substring(0, min(length, 64));
  }

  /// 문자열을 128자 이하로 자른다.
  String get cut128 {
    return substring(0, min(length, 128));
  }
}
