import 'package:food_delivery/features/notification/domain/repository/notification_repository.dart';

class GetInitialNotificationUsecase {
  final NotificationRepository _notificationRepository;

  GetInitialNotificationUsecase(this._notificationRepository);

  Future<void> getInitialNotification() {
    return _notificationRepository.getInitialNotification();
  }
}
