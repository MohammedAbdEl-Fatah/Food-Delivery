import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/widget/loading.dart';

class FoodItemImage extends StatefulWidget {
  const FoodItemImage({super.key, required this.imagePath});
  final String imagePath;

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
              imageUrl: widget.imagePath,
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
