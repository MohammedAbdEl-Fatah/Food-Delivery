import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';
import 'package:food_delivery/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_delivery/features/home/presentation/cubit/price/price.cubit.dart';

class BottonBarDetailCard extends StatelessWidget {
  final ProductEntity product;

  const BottonBarDetailCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceStatus>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 125,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //cubit connected with cart
                  _addOrRemoveItem(state, context),
                  _totalPrice(price: state.totalprice),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  log("add product to cart from detials page");
                  context.read<CartCubit>().addProductToCart(product);
                },
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor: const WidgetStatePropertyAll(
                    ColorManager.primary,
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    const Icon(
                      FontAwesomeIcons.cartShopping,
                      color: ColorManager.white,
                    ),
                    Text(
                      'Add to Cart',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addOrRemoveItem(PriceStatus state, BuildContext context) {
    return Row(
      children: [
        //
        IconButton(
          onPressed: () {
            context.read<PriceCubit>().decrementPrice();
          },
          icon: const Icon(FontAwesomeIcons.minus),
          color: ColorManager.black,
        ),
        Text(
          state.quantity.toString(),
          style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            context.read<PriceCubit>().incrementPrice();
          },
          icon: const Icon(FontAwesomeIcons.plus),
          color: ColorManager.black,
        ),
      ],
    );
  }

  Widget _totalPrice({int count = 1, required int price}) {
    int totalprice = count * price;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        '\$ ${totalprice.withComma}',
        style: AppTextStyle.header5.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
