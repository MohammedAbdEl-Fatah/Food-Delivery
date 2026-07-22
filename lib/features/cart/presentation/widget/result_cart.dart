import 'package:flutter/widgets.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';

class ResultCart extends StatelessWidget {
  const ResultCart({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: _detailsSummery(),
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
}
