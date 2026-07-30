import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //navigtaion to screen order or waitting delivery and payment catch
      },
      clipBehavior: Clip.antiAlias,
      style: ElevatedButton.styleFrom(
        elevation: 3,

        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.32,
          vertical: MediaQuery.of(context).size.height * 0.0125,
        ),
      ),
      child: Text(
        'Order',
        style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
