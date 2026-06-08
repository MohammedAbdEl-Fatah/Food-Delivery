import 'package:food_delivery/features/notification/domain/entity/notification_entity.dart';
import 'package:food_delivery/features/notification/domain/repository/notification_repository.dart';

import '../datasource/fcm_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FCMDataSource datasource;
  NotificationRepositoryImpl(this.datasource);
  @override
  Stream<NotificationEntity> get foregroundNotifications =>
      datasource.getForegroundNotification();

  @override
  Future<NotificationEntity?> getInitialNotification() =>
      datasource.getInitialNotification();

  @override
  Stream<NotificationEntity> get notificationTap =>
      datasource.getNotificationTap();

  @override
  Future<void> requestPermisson() => datasource.requestPermission();
}
