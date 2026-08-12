import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/Colors/color_manager.dart';

class EditTextProfile extends StatelessWidget {
  const EditTextProfile({
    super.key,
    required this.text,
    required this.controller,
    required this.hintText,
  });
  final String text;
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: _buildBorder(),
            border: _buildBorder(),
            focusedBorder: _buildBorder().copyWith(
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            focusColor: ColorManager.primary,
            // fillColor: ColorManager.white,
            hintText: hintText,
            hintStyle: AppTextStyle.bodyLarge.copyWith(
              color: ColorManager.black.withAlpha((255 * 0.5).toInt()),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: ColorManager.black.withAlpha((255 * 0.9).toInt()),
      ),
    );
  }
}
