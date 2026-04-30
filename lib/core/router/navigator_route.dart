import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import '../../features/auth/presentation/views/auth.dart';
import '../../features/auth/forget_password/presentation/forget_password.dart';
import '../../features/auth/log_in/presentation/view/login.dart';
import '../../features/auth/otp/presentation/otp_view.dart';
import '../../features/auth/reset_password/presentation/reset_password.dart';
import '../../features/auth/register/presentation/view/register_screen.dart';
import '../../features/botton_nav_bar/presentation/views/main_page.dart';
import '../../features/home/presentation/view/details_card.dart';
import '../../features/home/presentation/view/home_page.dart';
import '../../features/home/presentation/view/notification_screen.dart';
import '../../features/onboarding/presentation/views/on_boarding_page.dart';
import '../../features/home/presentation/view/all_product.dart';
import '../../features/profile/presentation/views/edit_profile.dart';

class NavigatorRoute {
  // ignore: body_might_complete_normally_nullable
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ContentsRouter.auth:
        return MaterialPageRoute(
          builder: (_) => const Auth(),
          settings: settings,
        );
      case ContentsRouter.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
          settings: settings,
        );
      case ContentsRouter.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case ContentsRouter.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: settings,
        );
      case ContentsRouter.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case ContentsRouter.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case ContentsRouter.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgetPassword(),
          settings: settings,
        );
      case ContentsRouter.otpView:
        return MaterialPageRoute(
          builder: (_) => const OtpView(),
          settings: settings,
        );
      case ContentsRouter.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPassword(),
          settings: settings,
        );
      case ContentsRouter.editProfilePage:
        return MaterialPageRoute(
          builder: (_) => const EditProfilePage(),
          settings: settings,
        );
      case ContentsRouter.detailsCard:
        return MaterialPageRoute(
          builder: (_) => const DetailsCard(),
          settings: settings,
        );
      case ContentsRouter.allProduct:
        return MaterialPageRoute(
          builder: (_) => const AllProduct(),
          settings: settings,
        );
      case ContentsRouter.notificationScreen:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
          settings: settings,
        );
    }
  }
}
