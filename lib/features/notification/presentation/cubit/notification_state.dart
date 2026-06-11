part of "notification_cubit.dart";

sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<NotificationEntity> notifications;
  NotificationLoadedState(this.notifications);

  List<NotificationEntity> get unread =>
      notifications.where((n) => !n.isRead).toList();
  List<NotificationEntity> get read =>
      notifications.where((n) => n.isRead).toList();
}

class NotificationBannerVisibleState extends NotificationState {
  final NotificationEntity notificationEntity;
  NotificationBannerVisibleState({required this.notificationEntity});
}

class NotificationBannerHiddenState extends NotificationState {}

class NotificationScreenOpenState extends NotificationState {
  final NotificationEntity notificationEntity;
  NotificationScreenOpenState({required this.notificationEntity});
}
