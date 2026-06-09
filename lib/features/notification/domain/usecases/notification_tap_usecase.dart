import 'package:food_delivery/features/notification/domain/repository/notification_repository.dart';

import '../entity/notification_entity.dart';

class NotificationTapUsecase {
  final NotificationRepository _notificationRepository;

  NotificationTapUsecase(this._notificationRepository);

  Stream<NotificationEntity> call() {
    return _notificationRepository.notificationTap;
  }
}
