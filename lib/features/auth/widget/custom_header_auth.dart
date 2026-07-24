import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CustomHeaderAuth extends StatelessWidget {
  const CustomHeaderAuth({
    super.key,
    required this.text,
    required this.subText,
  });
  final String text;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyle.header4.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Opacity(
          opacity: 0.6,
          child: Text(
            subText,
            style: AppTextStyle.bodyMedium.copyWith(
              color: ColorManager.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
