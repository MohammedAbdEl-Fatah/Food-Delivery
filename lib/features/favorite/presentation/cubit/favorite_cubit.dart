import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/model/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(AddFavorite(items: []));

  // Add a product to the favorites list
  void addFavorite(ProductEntity product) {
    log('Adding product to favorites: ${product.title}');

    final updatedItems = List<ProductEntity>.from(state.items);

    final exists = updatedItems.any((item) {
      log('Checking if product exists: ${item.title} == ${product.title}');
      return item.title == product.title;
    });

    if (!exists) {
      updatedItems.add(product);
      emit(AddFavorite(items: updatedItems));
    }
  }

  // Remove a product from the favorites list
  void removeFavorite(ProductEntity product) {
    log('Removing product from favorites: ${product.title}');
    if (!state.items.contains(product)) return;
    List<ProductEntity> updatedItems = List.from(state.items)..remove(product);
    emit(RemoveFavorite(items: updatedItems));
  }
}
