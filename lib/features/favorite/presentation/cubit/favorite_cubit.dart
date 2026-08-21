import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/model/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(AddFavorite(items: []));

  bool isFavorite(String productId) {
    return state.items.any((item) => item.title == productId);
  }

  void toggleFavorite(ProductEntity product) {
    if (isFavorite(product.title)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }

  void addFavorite(ProductEntity product) {
    if (isFavorite(product.title)) return;

    log('Adding product to favorites: ${product.title}');
    emit(AddFavorite(items: [...state.items, product]));
  }

  void removeFavorite(ProductEntity product) {
    if (!isFavorite(product.title)) return;

    log('Removing product from favorites: ${product.title}');
    emit(
      RemoveFavorite(
        items: state.items.where((item) => item.title != product.title).toList(),
      ),
    );
  }
}
