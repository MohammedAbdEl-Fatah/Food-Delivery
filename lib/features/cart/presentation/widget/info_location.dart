
import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart' show ColorManager;

import '../../../../core/style/app_text_style.dart';

class InfoLocation extends StatelessWidget {
  const InfoLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Location',
              style: AppTextStyle.bodyMedium.copyWith(
                color: ColorManager.grey.withAlpha((250 * 0.6).ceil()),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Home',
              style: AppTextStyle.bodyMedium.copyWith(
                color: ColorManager.black.withAlpha(250),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.white,
            side: const BorderSide(color: ColorManager.primary),
            elevation: 0,
          ),
          child: Text(
            'Change Location',
            style: AppTextStyle.bodyMedium.copyWith(
              color: ColorManager.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
