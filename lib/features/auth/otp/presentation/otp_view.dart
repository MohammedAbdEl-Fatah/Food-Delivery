import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/mail/mail.dart';
import 'package:food_delivery/core/utils/otp_generator.dart';
import 'package:food_delivery/features/auth/widget/custom_app_bar.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/widget/otp_digit_field.dart';

import '../../../../core/router/contents_router.dart';
import '../../../../core/widget/show_snack_bar.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String _otpCode = '';
  String _generatedOTP = '';
  DateTime? _otpExpiryTime;
  bool _isCorrect = false;
  bool _isError = false;
  bool _isExpired = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Timer variables
  int _secondsRemaining = 60;
  bool _canResend = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.stop();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateAndSendOTP();
    });
    // Start timer
    _startTimer();
  }

  Future<void> _generateAndSendOTP() async {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    _generatedOTP = OTPGenerator.generateOTP();
    _otpExpiryTime = DateTime.now().add(const Duration(minutes: 3));

    bool sent = await MailService.sendOTP(email, _generatedOTP);

    if (sent) {
      AppSnackBar.success(context, message: 'OTP sent to $email');
    } else {
      AppSnackBar.error(
        context,
        message: 'Failed to send OTP. Please try again.',
      );
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendOTP() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
      // Generate and send new OTP
      _generateAndSendOTP();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _verifyOTP() {
    _otpCode = _controllers.map((c) => c.text).join();

    // Check if OTP is expired
    if (_otpExpiryTime != null && DateTime.now().isAfter(_otpExpiryTime!)) {
      setState(() {
        _isExpired = true;
        _isError = true;
      });
      //TODO test line
      HapticFeedback.vibrate();
      AppSnackBar.error(
        context,
        message: 'OTP has expired. Please request a new one.',
      );
      return;
    }

    if (_otpCode == _generatedOTP) {
      setState(() {
        _isCorrect = true;
        _isError = false;
        _isExpired = false;
      });
      _animationController.forward(from: 0.0);
      AppSnackBar.success(context, message: 'OTP Verified!');
      Future.delayed(const Duration(milliseconds: 1200), () {
        Navigator.pushReplacementNamed(context, ContentsRouter.resetPassword);
      });
    } else {
      setState(() {
        _isCorrect = false;
        _isError = true;
        _isExpired = false;
      });
      _animationController.stop();
      HapticFeedback.vibrate();
      AppSnackBar.error(context, message: 'Invalid OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fieldWidth = screenWidth * 0.12;
    final double paddingHorizontal = screenWidth * 0.03;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(text: TextString.otpVerify),
            CustomHeaderAuth(
              text: TextString.emailVerify,
              subText: "${TextString.subEmailVerify} \n$email",
            ),
            const SizedBox(height: 20),
            ScaleTransition(
              scale:
                  _isCorrect
                      ? _scaleAnimation
                      : const AlwaysStoppedAnimation(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return OtpDigitField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    isError: _isError,
                    isCorrect: _isCorrect,
                    isExpired: _isExpired,
                    width: fieldWidth,
                    scaleAnimation: _isCorrect ? _scaleAnimation : null,
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNodes[index - 1]);
                      }
                    },
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
            // Timer and Resend OTP
            if (!_canResend)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Resend OTP in ${_secondsRemaining}s',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            if (_canResend)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: GestureDetector(
                    onTap: _resendOTP,
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            // CustomButtonAuth
            Center(
              child: CustomButtonAuth(
                onTap: _verifyOTP,
                text: TextString.verifyAccount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
