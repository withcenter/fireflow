import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/serialization_util.dart';
import 'package:fireflow/src/push_notifications/message.model.dart';
import 'package:flutter/foundation.dart';

class MessagingService {
  static MessagingService get instance => _instance ??= MessagingService();
  static MessagingService? _instance;

  final kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

  MessagingService() {
    print('MessagingService()');
  }

  init() {
    if (kIsWeb) return;
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

  /// User tapped on the notification.
  ///
  /// It needs to parse the parameters and navigate to the right page.
  ///
  /// 여기서 부터, ... notification 으로 부터 전달받은 값을 reference 로 변경하여, 각 페이지로 이동한다. 각 Schema Document 로는 변경하기 어렵다.
  onTapMessage(MessageModel message) async {
    /// 채팅 푸시 알림?
    ///
    if (AppService.instance.onTapMessage != null) {
      AppService.instance.onTapMessage!(
          message.data.initialPageName, message.data.parameterData);
    }
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
}
