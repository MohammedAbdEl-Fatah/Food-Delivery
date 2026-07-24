import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/features/auth/widget/custom_button_auth.dart';
import '../../../core/Colors/color_manager.dart';
import '../../../core/style/app_text_style.dart';

class CustomShowBottomSheet extends StatelessWidget {
  const CustomShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageResources.success),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                TextString.changePassword,
                textAlign: TextAlign.center,
                style: AppTextStyle.header4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Text(
                  TextString.subChangePassword,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: ColorManager.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomButtonAuth(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ContentsRouter.login,
                (route) => false,
              );
            },
            text: TextString.verifyAccount,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
