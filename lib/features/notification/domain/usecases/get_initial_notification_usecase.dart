import 'package:food_delivery/features/notification/domain/repository/notification_repository.dart';

import '../entity/notification_entity.dart';

class GetInitialNotificationUsecase {
  final NotificationRepository _notificationRepository;

  GetInitialNotificationUsecase(this._notificationRepository);

  Future<NotificationEntity?> getInitialNotification() {
    return _notificationRepository.getInitialNotification();
  }
}
