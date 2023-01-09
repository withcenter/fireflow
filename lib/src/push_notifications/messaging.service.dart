import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/functions/serialization_util.dart';

class MessagingService {
  static MessagingService get instance => _instance ??= MessagingService();
  static MessagingService? _instance;

  final kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

  MessagingService() {
    print('MessagingService()');
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
