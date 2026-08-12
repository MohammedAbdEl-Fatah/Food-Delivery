import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';

class ResetEmailSentBottomSheet extends StatelessWidget {
  const ResetEmailSentBottomSheet({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageResources.success),
            const SizedBox(height: 8),
            Text(
              TextString.resetEmailSent,
              textAlign: TextAlign.center,
              style: AppTextStyle.header4.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Opacity(
              opacity: 0.6,
              child: Text(
                '${TextString.subResetEmailSent}\n$email',
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: ColorManager.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButtonAuth(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              text: TextString.backToLogin,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
