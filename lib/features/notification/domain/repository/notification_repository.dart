import 'package:food_delivery/features/notification/domain/entity/notification_entity.dart';

abstract class NotificationRepository {
  Stream<NotificationEntity> get foregroundNotifications;
  Stream<NotificationEntity> get notificationTap;
  Future<NotificationEntity?> getInitialNotification();
  Future<void> requestPermisson();
}
