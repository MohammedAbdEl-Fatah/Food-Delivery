import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/utils/helper/validation_text_field.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_divider.dart';
import 'package:food_delivery/features/auth/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/widget/custom_method_sign_in.dart';
import 'package:food_delivery/features/auth/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/auth/widget/custom_text_login.dart';
import 'package:food_delivery/features/auth/widget/header.dart';
import '../../../../../core/contents/enum.dart';
import '../../../../../core/router/contents_router.dart';
import '../../../../../core/style/app_text_style.dart';
import '../../../../../core/widget/show_snack_bar.dart';
import '../../../otp/domain/otp_verification_args.dart';
import '../cubit/register_cubit.dart';

class Register extends StatefulWidget {
  Register({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: Loading()),
                  );
                } else if (state is RegisterSuccess) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); // Close loading dialog if open
                  }
                  Navigator.pushReplacementNamed(
                    context,
                    ContentsRouter.otpView,
                    arguments: OtpVerificationArgs(
                      contact: state.user.email,
                      flow: OtpFlow.register,
                      userId: state.user.id,
                    ),
                  );
                } else if (state is RegisterFailure) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); // Close loading dialog if open
                  }
                  AppSnackBar.error(
                    context,
                    message: 'Registration failed: ${state.error}',
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<RegisterCubit>();
                return Form(
                  key: widget._formKey, // Use the widget's key here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHeaderAuth(
                        text: TextString.headerRegister,
                        subText: TextString.headerSubRegister,
                      ),
                      const SizedBox(height: 12),
                      header(TextString.headerRegisterUserName),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cubit.nameController,
                        focusNode: cubit.nameFocusNode,
                        hint: TextString.headerRegisterUserName,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(cubit.emailFocusNode),
                        validator: ValidationTextField.name(),
                      ),
                      const SizedBox(height: 14),
                      header(TextString.headerEmail),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cubit.emailController,
                        focusNode: cubit.emailFocusNode,
                        hint: TextString.headerEmail,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(cubit.passwordFocusNode),
                        validator: ValidationTextField.email(),
                      ),
                      const SizedBox(height: 8),
                      header(TextString.headerPhone),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cubit.phoneController,
                        focusNode: cubit.phoneFocusNode,
                        hint: TextString.headerPhone,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(cubit.passwordFocusNode),
                        validator: ValidationTextField.phoneNumber(),
                      ),
                      const SizedBox(height: 14),
                      header(TextString.headerPassword),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cubit.passwordController,
                        focusNode: cubit.passwordFocusNode,
                        hint: TextString.headerPassword,
                        isPassword: true,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(cubit.confirmPasswordFocusNode),
                        validator: ValidationTextField.password(),
                      ),
                      const SizedBox(height: 14),
                      header(TextString.headerRegisterConfirmPassword),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: cubit.confirmPasswordController,
                        focusNode: cubit.confirmPasswordFocusNode,
                        hint: TextString.headerRegisterConfirmPassword,
                        isPassword: true,
                        onFieldSubmitted:
                            (_) => FocusScope.of(context).unfocus(),
                        validator: ValidationTextField.confirmPassword(
                          cubit.passwordController,
                        ),
                      ),
                      const SizedBox(height: 14),
                      header('Birthday'),
                      const SizedBox(height: 8),
                      FormField<DateTime>(
                        initialValue: cubit.birthday,
                        validator: ValidationTextField.birthday(),

                        builder: (field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final selected = await showDatePicker(
                                    fieldHintText: "enter birthday",
                                    context: context,
                                    initialDate: DateTime.now().subtract(
                                      const Duration(days: 365 * 20),
                                    ),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: ColorManager.primary,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black,
                                            onSecondary: ColorManager.grey,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  ColorManager.primary,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selected != null) {
                                    cubit.updateBirthday(selected);
                                    field.didChange(
                                      selected,
                                    ); // Update form field
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          field.hasError
                                              ? ColorManager.error
                                              : ColorManager.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    cubit.birthday != null
                                        ? '${cubit.birthday!.day}/${cubit.birthday!.month}/${cubit.birthday!.year}'
                                        : 'Select Birthday',
                                    style: TextStyle(
                                      color:
                                          cubit.birthday == null
                                              ? ColorManager.grey
                                              : ColorManager.black,
                                    ),
                                  ),
                                ),
                              ),
                              if (field.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    field.errorText!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      header('Gender'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<GENDER>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorManager.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorManager.primary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        elevation: 4,
                        focusColor: ColorManager.white,
                        initialValue: cubit.gender,
                        hint: Text(
                          'Select Gender',
                          style: AppTextStyle.bodyLarge.copyWith(
                            color: ColorManager.grey,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: GENDER.male,
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: GENDER.female,
                            child: Text('Female'),
                          ),
                        ],
                        onChanged: (value) {
                          cubit.updateGender(value); // updateGender(GENDER?)
                        },
                        validator:
                            (value) =>
                                value == null ? 'Please select gender' : null,
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButtonAuth(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (widget._formKey.currentState?.validate() ??
                                false) {
                              cubit.register();
                            }
                          },
                          text: TextString.submit,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const CustomDivider(),
                      const SizedBox(height: 24),
                      const CustomMethodSignIn(),
                      const SizedBox(height: 32),
                      const CustomTextLogin(),
                      const SizedBox(height: 14),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
