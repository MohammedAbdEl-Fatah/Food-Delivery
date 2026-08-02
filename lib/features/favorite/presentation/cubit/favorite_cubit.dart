import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(AddFavorite(items: []));

  // Add a product to the favorites list
  void addFavorite(dynamic product) {
    final updatedItems = List.from(state.items);

    if (!updatedItems.contains(product)) {
      updatedItems.add(product);
      emit(AddFavorite(items: updatedItems));
    }
  }

  // Remove a product from the favorites list
  void removeFavorite(dynamic product) {
    if(!state.items.contains(product)) return;
    final updatedItems = List.from(state.items)..remove(product);
    emit(RemoveFavorite(items: updatedItems));
  }
}
