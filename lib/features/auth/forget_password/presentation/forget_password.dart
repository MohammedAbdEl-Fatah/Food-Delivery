import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/widget/show_snack_bar.dart';
import 'package:food_delivery/features/auth/forget_password/data/firebase_forgot_password_data_source.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_test_form_filed.dart';
import '../../../../core/utils/helper/validation_text_field.dart';
import '../../../../core/style/app_size.dart';
import '../../widget/reset_email_sent_bottom_sheet.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseForgotPasswordDataSource _forgotPasswordDataSource =
      FirebaseForgotPasswordDataSource();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      await _forgotPasswordDataSource.sendPasswordResetEmail(email);

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ResetEmailSentBottomSheet(email: email),
      );
    } on ForgotPasswordException catch (e) {
      if (!mounted) return;

      AppSnackBar.error(context, message: e.message);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      AppSnackBar.error(
        context,
        message: _mapFirebaseAuthError(e),
      );
    } catch (e) {
      if (!mounted) return;

      AppSnackBar.error(
        context,
        message: 'Failed to send reset email. Please try again.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'Failed to send reset email. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomHeaderAuth(
                        text: TextString.headerForgetPassword,
                        subText: TextString.headerSubForgetPassword,
                      ),
                      AppSize.applyPadding(height: 10),
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        hint: TextString.headerEmail,
                        validator: ValidationTextField.email(),
                      ),
                      AppSize.applyPadding(height: 10),
                    ],
                  ),
                ),
              ),
              CustomButtonAuth(
                onTap: _sendPasswordResetEmail,
                text: _isLoading ? "Sending..." : TextString.continues,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
