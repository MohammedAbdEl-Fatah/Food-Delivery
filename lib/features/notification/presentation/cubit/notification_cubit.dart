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

  Future<void> init() async {
    // Case 1: app was killed, user tapped notification
    final initial = await _getInitial();
    if (initial != null) {
      emit(NotificationScreenOpenState(notificationEntity: initial));
    }

    // Case 2: app in foreground → show custom banner
    _foregroundSub = _listenForeground().listen((notification) {
      emit(NotificationBannerVisibleState(notificationEntity: notification));
    });

    // Case 3: app in background, user taps → navigate to screen
    _tapSub = _listenTaps().listen((notification) {
      emit(NotificationScreenOpenState(notificationEntity: notification));
    });
  }

  void hideBanner() => emit(NotificationBannerHiddenState());

  @override
  Future<void> close() {
    _foregroundSub?.cancel();
    _tapSub?.cancel();
    return super.close();
  }
}
