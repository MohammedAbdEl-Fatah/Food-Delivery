
part of 'favorite_cubit.dart';
sealed class FavoriteState {
  List items;
  FavoriteState({required this.items});
}

class AddFavorite extends FavoriteState {
  AddFavorite({required super.items});
}

class RemoveFavorite extends FavoriteState {
  RemoveFavorite({required super.items});
}
