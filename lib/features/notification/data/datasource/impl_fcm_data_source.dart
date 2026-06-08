import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/features/notification/data/datasource/fcm_data_source.dart';
import 'package:food_delivery/features/notification/domain/entity/notification_entity.dart';

class ImplFcmDataSource implements FCMDataSource {
  final FirebaseMessaging _message;

  ImplFcmDataSource(this._message);
  //more clean code when using map or object ====== NotificationEntity
  NotificationEntity _mapToEntity(RemoteMessage message) {
    return NotificationEntity(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: message.data,
      receivedAt: DateTime.now(),
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
