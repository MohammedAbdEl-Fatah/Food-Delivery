import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/di/servier_locator.dart';
import 'package:food_delivery/core/router/app_navigator.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/router/navigator_route.dart';
import 'package:food_delivery/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:food_delivery/features/auth/log_in/data/repository/firebase_log_in_repository.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_google_usecase.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_usecase.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/login/login_cubit.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/google_login/google_login_cubit.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/google_login/google_login_state.dart';
import 'package:food_delivery/features/onboarding/presentation/cubit/on_boarding_cubit.dart';

import 'core/widget/show_snack_bar.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/favorite/presentation/cubit/favorite_cubit.dart';

class MyApp extends StatelessWidget {
  final String start;
  const MyApp({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingCubit()),
        BlocProvider(
          create:
              (context) => LoginCubit(
                logInUseCase: LogInInUseCase(FirebaseLogInRepository()),
              ),
        ),
        BlocProvider(
          create:
              (context) => GoogleLoginCubit(
                loginGoogleUsecase: LoginGoogleUsecase(
                  FirebaseLogInRepository(),
                ),
              ),
        ),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],

      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.grey.withAlpha(
            150,
          ), // Make status bar transparent
          statusBarIconBrightness: Brightness.light, // White icons on Android
          statusBarBrightness:
              Brightness
                  .dark, // Dark status bar for iOS (opposite of icon brightness)
        ),
        child: BlocProvider.value(
          value: sl<NotificationCubit>(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<NotificationCubit, NotificationState>(
                listenWhen:
                    (previous, current) =>
                        current is NotificationScreenOpenState,
                listener: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    navigatorKey.currentState?.pushNamed(
                      ContentsRouter.notificationScreen,
                    );
                  });
                },
              ),
              BlocListener<GoogleLoginCubit, GoogleLoginState>(
                listener: (context, state) {
                  final navigator = navigatorKey.currentState;
                  final rootContext = navigatorKey.currentContext;
                  if (navigator == null || rootContext == null) return;

                  if (state is GoogleLoginLoading) {
                    showDialog<void>(
                      context: rootContext,
                      barrierDismissible: false,
                      useRootNavigator: true,
                      routeSettings: const RouteSettings(
                        name: '/google-login-loading',
                      ),
                      builder: (_) => const Center(child: Loading()),
                    );
                  } else if (state is GoogleLoginSuccess) {
                    navigator.popUntil(
                      (route) => route.settings.name != '/google-login-loading',
                    );
                    navigator.pushNamedAndRemoveUntil(
                      ContentsRouter.layout,
                      (route) => false,
                    );
                  } else if (state is GoogleLoginFailure) {
                    navigator.popUntil(
                      (route) => route.settings.name != '/google-login-loading',
                    );
                    final isGoogleAuthenticated = FirebaseAuth
                        .instance
                        .currentUser
                        ?.providerData
                        .any((provider) => provider.providerId == 'google.com');
                    if (isGoogleAuthenticated == true) {
                      navigator.pushNamedAndRemoveUntil(
                        ContentsRouter.layout,
                        (route) => false,
                      );
                      return;
                    }
                    AppSnackBar.error(context, message: state.errorMessage);
                  }
                },
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: "Food Delivery App",
              initialRoute: start,
              onGenerateRoute: NavigatorRoute.generateRoute,
              theme: ThemeData(
                scaffoldBackgroundColor: ColorManager.white,
                primaryColor: ColorManager.primary,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: ColorManager.primary, //cursor
                  selectionHandleColor:
                      ColorManager.primary, // pointer of cursor
                  selectionColor: ColorManager.primary.withValues(
                    alpha: 0.3,
                  ), // shadow select
                ),
              ),
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      ),
    );
  }
}
