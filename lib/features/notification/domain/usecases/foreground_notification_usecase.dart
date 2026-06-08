import 'package:food_delivery/features/notification/domain/repository/notification_repository.dart';

import '../entity/notification_entity.dart';

class ForegroundNotificationUsecase {
  final NotificationRepository _notificationRepository;

  ForegroundNotificationUsecase(this._notificationRepository);

  Stream<NotificationEntity> getForegroundNotifications() {
    return _notificationRepository.foregroundNotifications;
  }
}
