import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';
import 'package:food_delivery/features/home/presentation/widget/food_item_image.dart';

import '../../../../core/model/product_model.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: Column(
        spacing: MediaQuery.sizeOf(context).height * 0.005,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FoodItemImage(imagePath: product.urlImage ?? ""),
          _buildTitle(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: _buildPrice(context),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() => BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: ColorManager.grey.withAlpha(45),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(25),
  );

  Widget _buildTitle() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Text(
      product.title,
      style: AppTextStyle.bodyMedium.copyWith(
        color: ColorManager.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  Widget _buildPrice(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        '\$${product.price.withComma}',
        style: AppTextStyle.bodyLarge.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: () {
          log("add cart from grid");
          context.read<CartCubit>().addProductToCart(product);
        },
        icon: const Icon(
          FontAwesomeIcons.cartShopping,
          size: 18,
          color: ColorManager.primary,
        ),
      ),
    ],
  );
}
