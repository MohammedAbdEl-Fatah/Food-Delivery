import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/router/contents_router.dart';

class MethodPayment extends StatelessWidget {
  const MethodPayment({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    log(
      "Price from CashOnDeliveryScreen: $price",
      name: 'CashOnDeliveryScreen',
    );
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.credit_card,
            size: 30,
            color: ColorManager.primary,
          ),
          title: Text(
            'Credit Card',
            style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.w700),
          ),
          onTap: () {
            Navigator.popAndPushNamed(
              context,
              ContentsRouter.creditCardScreen,
              arguments: price,
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.payments_outlined,
            size: 30,
            color: ColorManager.primary,
          ),
          title: Text(
            'Cash on Delivery',
            style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.w700),
          ),
          onTap: () {
            Navigator.popAndPushNamed(
              context,
              ContentsRouter.cashOnDeliveryScreen,
              arguments: price,
            );
          },
        ),
      ],
    );
  }
}
