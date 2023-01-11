import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/serialization_util.dart';
import 'package:fireflow/src/push_notifications/message.model.dart';

class MessagingService {
  static MessagingService get instance => _instance ??= MessagingService();
  static MessagingService? _instance;

  final kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

  MessagingService() {
    print('MessagingService()');
  }

  init() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      /// This will triggered while the app is opened
      /// If the message has data, then do some extra work based on the data.
      ///

      final message = MessageModel.fromRemoteMessage(remoteMessage);

      log('--> initMessaging::onMessage; $message');

      log('Notification: ${message.notification}, ${message.notification.title}, ${message.notification.body}');

      /// Is this message coming from the chat room I am chatting in?
      if (AppService.instance.currentChatRoomDocumentReference != null &&
          AppService.instance.currentChatRoomDocumentReference?.id ==
              message.data.chatRoomDocumentReference?.id) {
        print('---> I am chatting with this user already. Do not show a notification.');
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
    ///

    if (AppService.instance.onTapMessage != null) {
      AppService.instance.onTapMessage!(message.data.initialPageName, message.data.parameterData);
    }

    // AppService.instance.context
    //     .pushNamed(message.data.initialPageName, queryParams: message.data.parameterData);
    // if (message.data.initialPageName == 'ChatRoom') {
    //   final chatRoomRef = message.data.chatRoomDocumentReference!;
    //   print('Navigate to ChatRoomPage by context.pushNamed, ${chatRoomRef.id}');

    /// 1:1 채팅? 채팅방 id 에 하이픈(-)이 있으면 1:1 채팅.
    // if (chatRoomRef.id.contains('-')) {
    /// 1:1 채팅방이면 상대방의 정보를 가져와서 채팅방 페이지로 이동.
    /// 이 때, 사용자의 reference 만 넘겨도 되는지 확인을 한다.
    /// 어차피 여기서는 FF 의 Schema Record 로 변환 할 수 없다.
    /// 그래서, 정 안되면, 채팅방 페이지 문서에서, Document 외에 reference 를 옵션으로 받도록 한다.
    ///
    // final doc = await UsersPublicDataRecord.getDocumentOnce(
    //   db.collection('users_public_data').doc(message.data.senderUserDocumentReference.id),
    // );
    // context.pushNamed(
    //   'ChatRoom',
    //   queryParams: {'otherUserDocument': serializeParam(doc, ParamType.Document)}.withoutNulls,
    //   extra: <String, dynamic>{
    //     'otherUserDocument': doc,
    //   },
    // );
    // } else {
    // 그룹 채팅 방.
    // final doc = await ChatRoomsRecord.getDocumentOnce(chatRoomRef);
    // context.pushNamed(
    //   'ChatRoom',
    //   queryParams: {'chatRoomDocument': serializeParam(doc, ParamType.Document)}.withoutNulls,
    //   extra: <String, dynamic>{
    //     'chatRoomDocument': doc,
    //   },
    // );

    // Navigator.of(AppService.instance.context).pushNamed('ChatRoom', arguments: {
    //   'chatRoomDocument': chatRoomRef,
    // });

    // AppService.instance.context.pushNamed('ChatRoom', arguments: {
    //   'chatRoomDocument': chatRoomRef,
    // });
    // }

    //   return;
    // }

    // final pageBuilder = pageBuilderMap[message.data.initialPageName];
    // if (pageBuilder != null) {
    //   /// message.data.parameterData 는 문자열인데, 이것을 JSON 객체로 변경한다.
    //   /// 이 때, JSON 으로 변환하기 전에, users/<uid> 를 users_public_data/<uid> 로 변경한 후, JSON 객체로 변경한다.
    //   /// /users 컬렉션은 Firestore security 로 제한되어 읽을 수가 없다.
    //   final page = await pageBuilder(
    //     getInitialParameterData({
    //       "parameterData": message.data.parameterData.replaceAll('users/', 'users_public_data/')
    //     }),
    //   );
    //   await Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => page),
    //   );
    // }
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
    parameterData['isPushNotification'] = 'Y';
    parameterData['senderUserDocumentReference'] = UserService.instance.ref;

    /// Remove the current user from the list.
    userRefs.removeWhere((ref) => ref.id == UserService.instance.uid);

    final serializedParameterData = serializeParameterData(parameterData);
    final pushNotificationData = {
      'notification_title': notificationTitle,
      'notification_text': notificationText,
      if (notificationImageUrl != null) 'notification_image_url': notificationImageUrl,
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
