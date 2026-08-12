import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/google_login/google_login_cubit.dart';

class CustomMethodSignIn extends StatelessWidget {
  const CustomMethodSignIn({super.key});
  Widget customIcon({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap, child: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<GoogleLoginCubit>().logInWithGoogle();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.heightOf(context) * 0.01,
            horizontal: MediaQuery.widthOf(context) * 0.21,
          ),
        ),
        child: Text(
          "Google",
          style: AppTextStyle.header6.copyWith(color: ColorManager.white),
        ),
      ),
    );
  }
}
