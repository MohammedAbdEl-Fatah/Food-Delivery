import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/botton_nav_bar/presentation/cubit/change_page_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          children: [
            // header title
            _headerTitle(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            // body condtion
            // TODO : cubit swap UI when cart has or dosen't have products
            _buildCartEmpty(context),
            // _buildbodyhasCart(),
          ],
        ),
      ),
    );
  }

  Widget _headerTitle() {
    return Text(
      "My Cart ",
      style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCartEmpty(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
        //image
        Image.asset(
          ImageResources.emptyCart,
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height * 0.3,
        ),
        //text header
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
        Text(
          "Ouch! Hungry",
          style: AppTextStyle.header5.copyWith(fontWeight: FontWeight.bold),
        ),
        //subtext header
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
        Text(
          "Seems like you have not ordered any food yet",
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyLarge.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorManager.grey,
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
        //serach button /=> back to home ^_^
        ElevatedButton(
          onPressed: () {
            context.read<ChangePageCubit>().changePage(0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.25,
            ),
            elevation: 0,
          ),
          child: Text(
            'Find Foods',
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildbodyhasCart() {
    return Column(
      children: [
        //location
        Row(
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
        ),
        //textfield  promo code
        _buildPromoCodeField(),
        // SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

        //list of cart items
        //total price + details
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              style: BorderStyle.solid,
              color: ColorManager.grey.withValues(alpha: 250 * 0.6),
            ),
          ),
          child: _detailsSummery(),
        ),
        //botton order now
      ],
    );
  }

  Widget _detailsSummery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: AppTextStyle.bodyLarge.copyWith(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildRowText(
          text: "Total Items ",
          subText: "price",
          colorSubText: ColorManager.black,
          // count:,
        ),
        _buildRowText(
          text: "Delivery Fee",
          subText: "Free",
          colorSubText: ColorManager.black,
          // count:,
        ),
        _buildRowText(
          text: "Discount",
          subText: "number",
          colorSubText: ColorManager.primary,
          // count:,
        ),
        _buildRowText(
          text: "Total",
          subText: "price",
          colorSubText: ColorManager.black,
          // count:,
        ),
      ],
    );
  }

  Widget _buildRowText({
    required String text,
    required String subText,
    required Color colorSubText,
    int? count,
  }) {
    return Row(
      children: [
        Text(
          "$text ${count ?? ''}",
          style: AppTextStyle.bodyMedium.copyWith(
            color: ColorManager.grey.withAlpha((250 * 0.6).ceil()),
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          subText,
          style: AppTextStyle.bodyMedium.copyWith(
            color: colorSubText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeField() {
    return TextField(
      cursorColor: ColorManager.primary,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: ColorManager.grey),
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        hintText: 'Enter Promo Code',
        prefixIcon: const Icon(
          FontAwesomeIcons.percent,
          size: 16,
          color: ColorManager.primary,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.grey),
          borderRadius: BorderRadius.circular(25.0),
        ),

        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: ElevatedButton(
            onPressed: () {
              // Apply promo code logic
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              backgroundColor: ColorManager.primary,
              elevation: 0,
            ),
            child: Text(
              'Apply',
              style: AppTextStyle.bodySmall.copyWith(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
