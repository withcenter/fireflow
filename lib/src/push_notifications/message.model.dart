import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Note that, json['parameterData'] is a String. And it should be kept as a String here.

///
class MessageDataModel {
  final DocumentReference? chatRoomDocumentReference;
  final String initialPageName;
  final String parameterData;

  MessageDataModel({
    this.chatRoomDocumentReference,
    required this.initialPageName,
    required this.parameterData,
  });

  static FirebaseFirestore get db => FirebaseFirestore.instance;

  factory MessageDataModel.fromJson(Map<String, dynamic> json) {
    return MessageDataModel(
      chatRoomDocumentReference: json['chatRoomDocumentReference'] == null
          ? null
          : db.doc(json['chatRoomDocumentReference']),
      initialPageName: json['initialPageName'],
      parameterData: json['parameterData'],
    );
  }
}

class MessageModel {
  final String? title;
  final String? body;
  final MessageDataModel data;
  final MessageNotificationModel notification;

  MessageModel({this.title, this.body, required this.data, required this.notification});

  factory MessageModel.fromRemoteMessage(RemoteMessage message) {
    return MessageModel(
      title: message.notification?.title,
      body: message.notification?.body,
      data: MessageDataModel.fromJson(message.data),
      notification: MessageNotificationModel.fromJson(message.notification),
    );
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
}
