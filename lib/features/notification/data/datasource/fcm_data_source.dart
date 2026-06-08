import 'package:food_delivery/features/notification/domain/entity/notification_entity.dart';

abstract class FCMDataSource {
  Stream<NotificationEntity> getNotificationTap();
  Stream<NotificationEntity> getForegroundNotification();
  Future<NotificationEntity?> getInitialNotification();
  Future<void> requestPermission();
}
