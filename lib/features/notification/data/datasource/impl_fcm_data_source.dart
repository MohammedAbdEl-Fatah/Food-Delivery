import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/features/notification/data/datasource/fcm_data_source.dart';
import 'package:food_delivery/features/notification/domain/entity/notification_entity.dart';

class ImplFcmDataSource implements FCMDataSource {
  final FirebaseMessaging _message;

  ImplFcmDataSource(this._message);
  //more clean code when using map or object ====== NotificationEntity
  NotificationEntity _mapToEntity(RemoteMessage message) {
    final title =
        message.notification?.title ?? message.data['title']?.toString() ?? '';
    final body =
        message.notification?.body ?? message.data['body']?.toString() ?? '';
    final id =
        message.messageId ??
        message.data['id']?.toString() ??
        '${title}_${body}_${message.sentTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}';

    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      data: message.data,
      receivedAt: DateTime.now(),
      isRead: false,
      type: NotificationType.system, // TODO: make it dynamic based on data
    );
  }

  @override
  Future<NotificationEntity?> getInitialNotification() async {
    final message = await _message.getInitialMessage();
    return message != null ? _mapToEntity(message) : null;
  }

  @override
  Stream<NotificationEntity> getForegroundNotification() {
    return FirebaseMessaging.onMessage.map(_mapToEntity);
  }

  @override
  Stream<NotificationEntity> getNotificationTap() {
    return FirebaseMessaging.onMessageOpenedApp.map(_mapToEntity);
  }

  @override
  Future<void> requestPermission() async {
    await _message.requestPermission(alert: true, badge: true, sound: true);
  }
}
