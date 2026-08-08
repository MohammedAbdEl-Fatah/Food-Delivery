import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/router/contents_router.dart';

class MethodPayment extends StatelessWidget {
  const MethodPayment({super.key});

  @override
  Widget build(BuildContext context) {
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
            //TODO
            // Navigator.pop(context);
           Navigator.pushNamed(context, ContentsRouter.creditCardScreen);
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
            //TODO
            // Navigator.pop(context);  
           Navigator.pushNamed(context, ContentsRouter.cashOnDeliveryScreen);
          },
        ),
      ],
    );
  }
}
