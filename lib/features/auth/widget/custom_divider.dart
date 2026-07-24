import 'package:flutter/material.dart';
import '../../../core/Colors/color_manager.dart';
import '../../../core/contents/text_string.dart';
import '../../../core/style/app_text_style.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: ColorManager.grey, thickness: 1, endIndent: 8),
        ),
        Text(
          TextString.antherMethodSignin,
          style: AppTextStyle.bodyMedium.copyWith(
            color: ColorManager.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: Divider(color: ColorManager.grey, thickness: 1, indent: 8),
        ),
      ],
    );
  }
}
