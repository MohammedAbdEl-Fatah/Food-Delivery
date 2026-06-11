import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/notification/domain/usecases/foreground_notification_usecase.dart';
import 'package:food_delivery/features/notification/domain/usecases/get_initial_notification_usecase.dart';
import 'package:food_delivery/features/notification/domain/usecases/notification_tap_usecase.dart';

import '../../domain/entity/notification_entity.dart';
part "notification_state.dart";

class NotificationCubit extends Cubit<NotificationState> {
  final ForegroundNotificationUsecase _listenForeground;
  final NotificationTapUsecase _listenTaps;
  final GetInitialNotificationUsecase _getInitial;
  final List<NotificationEntity> _notifications = [];
  StreamSubscription? _foregroundSub;
  StreamSubscription? _tapSub;

  NotificationCubit({
    required ForegroundNotificationUsecase listenForeground,
    required NotificationTapUsecase listenTaps,
    required GetInitialNotificationUsecase getInitial,
  }) : _listenForeground = listenForeground,
       _listenTaps = listenTaps,
       _getInitial = getInitial,
       super(NotificationInitialState());

  void _emitLoaded() =>
      emit(NotificationLoadedState(List.from(_notifications)));

  Future<void> init() async {
    // TODO (Hive step): load saved notifications here
    // _notifications.addAll(await _localRepo.getAll());
    _emitLoaded();
    // Case 1: app was killed, user tapped notification
    final initial = await _getInitial();
    if (initial != null) {
      emit(NotificationScreenOpenState(notificationEntity: initial));
    }

    _foregroundSub = _listenForeground().listen(_handleForeground);
    _tapSub = _listenTaps().listen(_handleTap);
  }

  void _handleForeground(NotificationEntity n) {
    _notifications.insert(0, n);
    // TODO (Hive step): await _localRepo.save(n);
    emit(NotificationBannerVisibleState(notificationEntity: n));
  }

  void _handleTap(NotificationEntity n) {
    _markRead(n.id);
    emit(NotificationScreenOpenState(notificationEntity: n));
  }

  void markAsRead(String id) {
    _markRead(id);
    _emitLoaded();
  }

  void markAllRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    // TODO (Hive step): await _localRepo.saveAll(_notifications);
    _emitLoaded();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    // TODO (Hive step): await _localRepo.delete(id);
    _emitLoaded();
  }

  void _markRead(String id) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _notifications[idx] = _notifications[idx].copyWith(isRead: true);
      // TODO (Hive step): await _localRepo.save(_notifications[idx]);
    }
  }

  void hideBanner() => emit(NotificationBannerHiddenState());

  @override
  Future<void> close() {
    _foregroundSub?.cancel();
    _tapSub?.cancel();
    return super.close();
  }
}
