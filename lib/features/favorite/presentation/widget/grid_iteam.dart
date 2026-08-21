import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/favorite/presentation/cubit/favorite_cubit.dart';

class GridIteam extends StatelessWidget {
  const GridIteam({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    log("product is ${product.urlImage}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(product.title),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.urlImage ?? '',
                  placeholder: (context, url) => const Loading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: ColorManager.white.withValues(alpha: 0.92),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: 'Remove from favorites',
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    context.read<FavoriteCubit>().removeFavorite(product);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: ColorManager.error,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
