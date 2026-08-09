import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../payment/presentation/widget/method_payment.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key, required this.price});
  final String price;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => MethodPayment(price: price),
          backgroundColor: ColorManager.white,
          barrierColor: Colors.black.withAlpha(
            (255 * 0.5).toInt(),
          ), // Adjust the alpha value for transparency
          elevation: 3,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.35,
          ),
        );
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
