import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/my_app.dart';

import 'core/contents/enum.dart';
import 'core/di/servier_locator.dart';
import 'core/service/firebase_message_service.dart';
import 'core/storage/shared_preference.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    dotenv.load(fileName: "assets/.env"),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    AppPreferences.instance.init(),
  ]);

  await setupServiceLocator();
  await FirebaseMessageService().init();
  await sl<NotificationCubit>().init();

  final seenOnBoarding = AppPreferences.instance.getBool(
    key: SharedPreferenceKey.seenOnBoarding,
  );
  String start;
  if (!seenOnBoarding) {
    start = ContentsRouter.onBoarding;
  } else {
    start = ContentsRouter.auth;
  }
  runApp(MyApp(start: start));
}
