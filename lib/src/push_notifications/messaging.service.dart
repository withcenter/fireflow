import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/serialization_util.dart';
import 'package:flutter/foundation.dart';

class MessagingService {
  static MessagingService get instance => _instance ??= MessagingService();
  static MessagingService? _instance;

  final kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

  /// my token collection
  get fcmTokensGroupCol =>
      FirebaseFirestore.instance.collectionGroup('fcm_tokens');
  get myTokensCol => UserService.instance.ref.collection('fcm_tokens');

  MessagingService() {
    dog('MessagingService()');
  }

  init() async {
    if (kIsWeb) return;

    if (Config.instance.messaging == null) return;

    /// Push notification permission
    ///
    /// It's better to ask the premission when app starts.
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }
    FirebaseAuth.instance
        .authStateChanges()
        .where((user) => user != null)
        .map((user) => user!.uid)
        .distinct()
        .listen((event) async {
      if (Platform.isIOS) {}
      MessagingService.instance
          .updateToken(await FirebaseMessaging.instance.getToken());
      FirebaseMessaging.instance.onTokenRefresh
          .listen(MessagingService.instance.updateToken);
    });

    /// 푸시 알림 토큰 업데이트
    _foregroundMessageHandler();

    /// Background Message Listening
    _backgroundMessageHandler();
  }

  _foregroundMessageHandler() {
    if (Config.instance.messaging?.foreground == false) return;

    /// Foreground Message Listening
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      /// This will triggered while the app is opened
      /// If the message has data, then do some extra work based on the data.
      ///

      final message = MessageModel.fromRemoteMessage(remoteMessage);

      dog('--> initMessaging::onMessage; $message');
      // log('Notification: ${message.notification}, ${message.notification.title}, ${message.notification.body}');

      /// Is this message coming from the chat room I am chatting in?
      if (AppService.instance.currentChatRoomDocumentReference != null &&
          AppService.instance.currentChatRoomDocumentReference?.id ==
              message.data.chatRoomId) {
        dog('I am chatting with this user already. Do not show a notification.');
        return;
      }
      showFlushbar(
        title: message.notification.title,
        message: message.notification.body,
        onTap: () => onTapMessage(message),
      );
    });
  }

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> _backgroundMessageHandler() async {
    if (Config.instance.messaging?.background == false) return;
    // Get any messa
    //_foregroundMessageHandler() {
    //ges which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      onTapMessage(MessageModel.fromRemoteMessage(initialMessage));
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((initialMessage) =>
        onTapMessage(MessageModel.fromRemoteMessage(initialMessage)));
  }

  /// User tapped on the notification.
  ///
  /// It needs to parse the parameters and navigate to the right page.
  ///
  onTapMessage(MessageModel message) async {
    dog('onTapMessage: $message');
    Config.instance.messaging
        ?.onTap(message.data.initialPageName, message.data.parameterData);
  }

  /// Send push message.
  ///
  /// Send push notification by saving the data to the Firestore document.
  /// And the background function will do the rest.
  ///
  /// Note, this code re-uses the FF messaging system.
  Future send({
    required String? notificationTitle,
    required String? notificationText,
    String? notificationImageUrl,
    DateTime? scheduledTime,
    String? notificationSound,
    required List<DocumentReference> userRefs,
    required String initialPageName,
    required Map<String, dynamic> parameterData,
  }) async {
    if ((notificationTitle ?? '').isEmpty || (notificationText ?? '').isEmpty) {
      return;
    }

    parameterData['senderUserDocumentReference'] = UserService.instance.ref;

    /// Remove the current user from the list.
    userRefs.removeWhere((ref) => ref.id == UserService.instance.uid);

    /// Remove duplicated user refs.
    userRefs = userRefs.toSet().toList();

    dog('sendPushNotification: $userRefs, $initialPageName, $parameterData');

    if (userRefs.isEmpty) {
      return;
    }

    final serializedParameterData = serializeParameterData(parameterData);
    final pushNotificationData = {
      'notification_title': notificationTitle,
      'notification_text': notificationText,
      if (notificationImageUrl != null)
        'notification_image_url': notificationImageUrl,
      if (scheduledTime != null) 'scheduled_time': scheduledTime,
      if (notificationSound != null) 'notification_sound': notificationSound,
      'user_refs': userRefs.map((u) => u.path).join(','),
      'initial_page_name': initialPageName,
      'parameter_data': serializedParameterData,
      'sender': UserService.instance.ref,
      'timestamp': DateTime.now(),
    };
    return FirebaseFirestore.instance
        .collection(kUserPushNotificationsCollectionName)
        .doc()
        .set(pushNotificationData);
  }

  /// Returns the fcm_tokens documents of the users who have the same FCM token.
  ///
  /// Note that, muliple users may have the same FCM tokens if the app manages
  /// fcm tokens with fireflow while flutterflow prevents it.
  Future<QuerySnapshot<Map<String, dynamic>>> getTokenDocuments(token) {
    return fcmTokensGroupCol.where('fcm_token', isEqualTo: token).get();
  }

  /// Update the FCM token.
  updateToken(String? token) async {
    if (UserService.instance.notLoggedIn) return;
    dog('updateToken: $token');
    if (token == null) return;
    final snapshot = await getTokenDocuments(token);
    if (snapshot.size > 0) {
      dog('token already exists. skip.');
      return;
    } else {
      dog('token does not exist. add it.');
      myTokensCol.add({
        'fcm_token': token,
        'device_type': Platform.isIOS ? 'iOS' : 'Android',
        'created_at': FieldValue.serverTimestamp(),
      });
    }
  }
}
