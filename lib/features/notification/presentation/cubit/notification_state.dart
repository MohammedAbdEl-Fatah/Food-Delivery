part of "notification_cubit.dart";

sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationBannerVisibleState extends NotificationState {
  final NotificationEntity notificationEntity;
  NotificationBannerVisibleState({required this.notificationEntity});
}

class NotificationBannerHiddenState extends NotificationState {}

class NotificationScreenOpenState extends NotificationState {
  final NotificationEntity notificationEntity;
  NotificationScreenOpenState({required this.notificationEntity});
}
