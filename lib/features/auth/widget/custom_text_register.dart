import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CustomTextRegister extends StatelessWidget {
  const CustomTextRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w500),
            children: [
              const TextSpan(
                text: TextString.headerDoNotHaveAccount,
                style: TextStyle(color: ColorManager.black),
              ),
              TextSpan(
                text: TextString.register,
                style: const TextStyle(color: ColorManager.primary),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        //navigator register
                        Navigator.pushNamed(context, ContentsRouter.register);
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
