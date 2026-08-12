import 'package:food_delivery/core/utils/config/env.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailService {
  static String username = Env.email;
  static String password = Env.password;

  static Future<bool> sendOTP(String recipientEmail, String otpCode) async {
    try {
      final smtpServer = gmail(username, password);

      final message =
          Message()
            ..from = Address(username, 'Food Delivery App')
            ..recipients.add(recipientEmail)
            // ..recipients.add('mohammedabdelfatah837@gmail.com')
            ..subject = 'Your OTP Code for Food Delivery'
            ..html = '''
              <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                <h2 style="color: #333;">Food Delivery - OTP Verification</h2>
                <p>Dear User,</p>
                <p>Your One-Time Password (OTP) for account verification is:</p>
                <div style="background-color: #f0f0f0; padding: 20px; text-align: center; border-radius: 8px; margin: 20px 0;">
                  <span style="font-size: 24px; font-weight: bold; letter-spacing: 3px; color: #007bff;">$otpCode</span>
                </div>
                <p>This OTP will expire in 5 minutes for security reasons.</p>
                <p>If you didn't request this OTP, please ignore this email.</p>
                <p>Best regards,<br>Food Delivery Team</p>
              </div>
            ''';

      await send(message, smtpServer);
      return true;
    // ignore: unused_catch_clause
    } on MailerException catch (e) {
      return false;
    }
  }
}
