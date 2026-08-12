import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';

import '../../domain/use_case/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase _useCase;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  DateTime? birthday;
  GENDER? gender;

  RegisterCubit(this._useCase) : super(RegisterInitial());

  Future<void> register(BuildContext context) async {
    if (birthday == null || gender == null) {
      emit(RegisterFailure('Please select birthday and gender'));
      return;
    }
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      emit(RegisterFailure('All fields are required'));
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      emit(RegisterFailure('Passwords do not match'));
      return;
    }
    emit(RegisterLoading());
    try {
      final result = await _useCase.execute(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        birthday: birthday!,
        gender: gender!.name,
      );
      result.fold(
        (failure) =>
            emit(RegisterFailure('Registration failed: ${failure.message}')),
        (user) {
          Navigator.of(context).pop();
          emit(RegisterSuccess(user));
        },
      );
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  void updateBirthday(DateTime? newBirthday) {
    birthday = newBirthday;
    emit(RegisterUpdated()); // Trigger rebuild if needed
  }

  void updateGender(GENDER? newGender) {
    gender = newGender;
    emit(RegisterUpdated());
  }

  @override
  Future<void> close() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    return super.close();
  }
}
