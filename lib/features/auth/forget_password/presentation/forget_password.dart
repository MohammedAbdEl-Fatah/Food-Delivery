import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/di/servier_locator.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_show_model_bottom_sheet.dart';
import 'package:food_delivery/features/auth/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/profile/domain/use_case/get_user_by_email.dart';
import '../../../../core/utils/helper/validation_text_field.dart';
import '../../../../core/style/app_size.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
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
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final email = _emailController.text.trim();
                    final getUserByEmail = sl<GetUserByEmail>();
                    final user = await getUserByEmail(email);

                    if (!mounted) return;

                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                          child: ForgotPasswordBottomSheet(
                            titleEmail: email,
                            titlePhone: user.phone,
                          ),
                        );
                      },
                    );
                  } catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Email not found. Please check your email address.',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                text: _isLoading ? "Checking..." : TextString.continues,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
