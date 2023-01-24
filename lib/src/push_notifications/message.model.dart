import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Push notification message modeling
///
///
/// See the [Push Notification Data Modeling](https://docs.google.com/document/d/1oZUnw60kcYuf-I5aIzETeD9ioqjydNTot1qhZ0q7MNY/edit#heading=h.3b8fun9rsitr) in document for more details.
class MessageModel {
  final String? title;
  final String? body;
  final MessageDataModel data;
  final MessageNotificationModel notification;

  MessageModel(
      {this.title, this.body, required this.data, required this.notification});

  factory MessageModel.fromRemoteMessage(RemoteMessage message) {
    return MessageModel(
      title: message.notification?.title,
      body: message.notification?.body,
      data: MessageDataModel.fromJson(message.data),
      notification: MessageNotificationModel.fromJson(message.notification),
    );
  }
  @override
  toString() {
    return 'MessageModel(title: $title, body: $body, data: $data, notification: $notification)';
  }
}

/// Note that, json['parameterData'] is a String. it needs to be converted as JSON.
///
/// See the [Push Notification Data Modeling](https://docs.google.com/document/d/1oZUnw60kcYuf-I5aIzETeD9ioqjydNTot1qhZ0q7MNY/edit#heading=h.3b8fun9rsitr) in document for more details.
class MessageDataModel {
  // final DocumentReference? chatRoomDocumentReference;
  final DocumentReference? senderUserDocumentReference;
  final String initialPageName;
  final Map<String, String> parameterData;
  final String? chatRoomId;

  MessageDataModel({
    required this.initialPageName,
    required this.parameterData,
    required this.senderUserDocumentReference,
    // this.chatRoomDocumentReference,
    this.chatRoomId,
  });

  static FirebaseFirestore get db => FirebaseFirestore.instance;

  /// Parse push notifiation data
  ///
  /// Note that, json['parameterData'] is a String. it needs to be converted as JSON.
  factory MessageDataModel.fromJson(Map<String, dynamic> json) {
    final params = jsonDecode(json['parameterData'] ?? {});
    final data = Map<String, String>.from(params);

    /// For forground push notification, the value of the Document or DocumentReference must be the ID of the document.
    //
    for (final key in data.keys) {
      if (key.endsWith('Document') || key.endsWith('DocumentReference')) {
        if (data[key]!.contains('/')) {
          data[key] = data[key]!.split('/').last;
        }
      }
    }

    return MessageDataModel(
      senderUserDocumentReference: params['senderUserDocumentReference'] == null
          ? null
          : db.doc(params['senderUserDocumentReference']),
      initialPageName: json['initialPageName'],
      parameterData: data,
      chatRoomId: params['chatRoomId'],
    );
  }
  @override
  toString() {
    return 'MessageDataModel(initialPageName: $initialPageName, parameterData: $parameterData, senderUserDocumentReference: $senderUserDocumentReference, chatRoomDocumentReference: chatRoomId: $chatRoomId)';
  }
}

class MessageNotificationModel {
  final String title;
  final String body;

  MessageNotificationModel({
    required this.title,
    required this.body,
  });

  factory MessageNotificationModel.fromJson(RemoteNotification? notification) {
    String title;
    String body;

    if (notification == null) {
      title = 'No title';
      body = 'No body';
    } else {
      title = notification.title ?? 'No title';
      body = notification.body ?? 'No body';
    }
    if (title.length > 64) title = title.substring(0, 64);
    if (body.length > 128) body = body.substring(0, 128);

    return MessageNotificationModel(
      title: title,
      body: body,
    );
  }

  @override
  toString() {
    return 'MessageNotificationModel(title: $title, body: $body)';
  }
}
