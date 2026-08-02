import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/widget/loading.dart';

import '../../../favorite/presentation/cubit/favorite_cubit.dart';

class FoodItemImage extends StatefulWidget {
  const FoodItemImage({super.key, required this.product});
  final ProductEntity product;
  // final String imagePath;

  @override
  // ignore: library_private_types_in_public_api
  _FoodItemImageState createState() => _FoodItemImageState();
}

class _FoodItemImageState extends State<FoodItemImage> {
  bool _isLoved = false;

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
            // child: Image.network(widget.imagePath, fit: BoxFit.cover),
            child: CachedNetworkImage(
              imageUrl: widget.product.urlImage!,
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
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLoved = !_isLoved;
                  _isLoved? context.read<FavoriteCubit>().addFavorite(widget.product) : context.read<FavoriteCubit>().removeFavorite(widget.product);
                });
              },
              child: Icon(
                Icons.favorite,
                color: _isLoved ? Colors.red : Colors.white,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
