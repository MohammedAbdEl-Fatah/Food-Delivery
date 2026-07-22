import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/style/app_text_style.dart' show AppTextStyle;

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/utils/helper/format_price.dart';
import '../../../../core/widget/loading.dart';
import '../../../home/presentation/cubit/price/price.cubit.dart';

class CartItemsView extends StatelessWidget {
  final List<ProductEntity> items;
  const CartItemsView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, PriceStatus>(
      builder: (context, state) {
        final product = items.isNotEmpty ? items[0] : null;
        if (product == null) return const SizedBox();

        return Card(
          color: ColorManager.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ColorManager.grey.withValues(alpha: 250 * 0.6),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: product.urlImage!,
              fadeInDuration: const Duration(milliseconds: 300),
              height: 200,
              width: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: Loading()),
              errorWidget:
                  (context, url, error) => const Icon(Icons.broken_image),
            ),
            title: Text(
              product.title,
              style: AppTextStyle.header5.copyWith(color: ColorManager.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _totalPrice(count: state.quantity, price: state.totalprice),
                _addOrRemoveItem(state, context),
              ],
            ),
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
          icon: const Icon(FontAwesomeIcons.minus, size: 21),
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
          icon: const Icon(FontAwesomeIcons.plus, size: 21),
          color: ColorManager.black,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // TODO: Implement remove item logic
          },

          icon: const Icon(FontAwesomeIcons.trash, size: 21),
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
        '\$ ${((totalprice / count).withComma)}',
        style: AppTextStyle.header6.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
