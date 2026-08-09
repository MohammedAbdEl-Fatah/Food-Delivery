import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_size.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/contents/images.dart';

class CashOnDeliveryScreen extends StatelessWidget {
  const CashOnDeliveryScreen({super.key});

  static DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final String price = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSize.applyPadding(
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
          ),
          //image
          Image.asset(
            ImageResources.success,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          const Text("Order Placed Successfully", style: AppTextStyle.header4),
          //description
          Text.rich(
            style: AppTextStyle.bodyLarge,
            TextSpan(
              text: "Your Payment of ",
              children: [
                TextSpan(
                  text: "\$$price",
                  style: AppTextStyle.header6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const TextSpan(text: " has been completed successfully."),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Divider(
            endIndent: MediaQuery.of(context).size.width * 0.05,
            indent: MediaQuery.of(context).size.width * 0.05,
          ),
          //Date and time
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  color: Colors.transparent,
                  shadowColor: ColorManager.primary.withAlpha(
                    (255 * 0.25).toInt(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.calendar_month,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date & Time",
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          CashOnDeliveryScreen.dateTime.toString().split(
                            ' ',
                          )[0],
                          style: AppTextStyle.bodyLarge,
                        ),
                        Text(
                          CashOnDeliveryScreen.dateTime
                              .toString()
                              .split(' ')[1]
                              .replaceRange(5, null, ''),
                          style: AppTextStyle.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Method of payment
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  color: Colors.transparent,
                  shadowColor: ColorManager.primary.withAlpha(
                    (255 * 0.25).toInt(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.credit_card_sharp,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //give the data from constaructor enum
                    const Text(
                      "Cash on Delivery",
                      style: AppTextStyle.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.045),
          //Button back to home
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
              ),
            ),
            child: Text(
              "Back to Home",
              style: AppTextStyle.bodyLarge.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
