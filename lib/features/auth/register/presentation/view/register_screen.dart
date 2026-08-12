import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/register/data/firebase/register_firebase_data_source.dart';
import '../../data/repository/register_repository.dart';
import '../../domain/use_case/register_use_case.dart';
import '../cubit/register_cubit.dart';
import 'register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => RegisterCubit(
            RegisterUserUseCase(
              RegisterRepositoryImpl(FirebaseRegisterDataSource()),
            ),
          ),
      child: Register(),
    );
  }
}
