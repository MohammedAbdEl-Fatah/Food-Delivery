import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/widget/loading.dart';

import '../../../favorite/presentation/cubit/favorite_cubit.dart';

class FoodItemImage extends StatelessWidget {
  const FoodItemImage({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: CachedNetworkImage(
              imageUrl: product.urlImage!,
              fadeInDuration: const Duration(milliseconds: 300),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: Loading()),
              errorWidget:
                  (context, url, error) => const Icon(Icons.broken_image),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: BlocSelector<FavoriteCubit, FavoriteState, bool>(
              selector:
                  (state) => state.items.any((item) => item.title == product.title),
              builder: (context, isLoved) {
                return GestureDetector(
                  onTap: () {
                    context.read<FavoriteCubit>().toggleFavorite(product);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: isLoved ? Colors.red : Colors.white,
                    size: 36,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
