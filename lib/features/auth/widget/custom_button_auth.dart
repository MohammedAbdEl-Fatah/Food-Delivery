import 'package:flutter/widgets.dart';

import '../../../core/Colors/color_manager.dart';
import '../../../core/style/app_text_style.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({super.key, required this.onTap, required this.text});

  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
