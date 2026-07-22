import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';
import '../../../../core/utils/helper/format_price.dart';
import '../cubit/cart_cubit.dart';

class ResultCart extends StatelessWidget {
  const ResultCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // Nothing to show until the cart actually has items.
        if (state is! CartIsNotEmpty) return const SizedBox();

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              style: BorderStyle.solid,
              color: ColorManager.grey.withValues(alpha: 250 * 0.6),
            ),
          ),
          child: _detailsSummery(state),
        );
      },
    );
  }

  Widget _detailsSummery(CartIsNotEmpty state) {
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
          text: "Total Items",
          subText: '\$ ${state.subtotal.withComma}',
          colorSubText: ColorManager.black,
        ),
        _buildRowText(
          text: "Delivery Fee",
          subText:
              state.deliveryFee == 0
                  ? "Free"
                  : '\$ ${state.deliveryFee.toStringAsFixed(2)}',
          colorSubText: ColorManager.black,
        ),
        // Only show a discount row when a promo code actually applied one.
        if (state.discountAmount > 0)
          _buildRowText(
            text: "Discount",
            subText: '- \$ ${state.discountAmount.toStringAsFixed(2)}',
            colorSubText: ColorManager.primary,
          ),
        _buildRowText(
          text: "Total",
          subText: '\$ ${state.total.toStringAsFixed(2)}',
          colorSubText: ColorManager.black,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
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
      ),
    );
  }
}