import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';
import '../cubit/cart_cubit.dart';

class PromoCodeField extends StatefulWidget {
  const PromoCodeField({super.key});

  @override
  State<PromoCodeField> createState() => _PromoCodeFieldState();
}

class _PromoCodeFieldState extends State<PromoCodeField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: ColorManager.primary,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: ColorManager.grey),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
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
              context.read<CartCubit>().applyPromoCode(_controller.text);
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