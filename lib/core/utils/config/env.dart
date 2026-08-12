import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String email = dotenv.env['USERNAME_MAILER']!;
  static String password = dotenv.env['PASSWORD_MAILER']!;
}
