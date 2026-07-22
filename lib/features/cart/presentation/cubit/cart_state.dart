part of 'cart_cubit.dart';

sealed class CartState {}
class CartEmpty extends CartState {}
class CartSwitchLoading extends CartState {}
class CartIsNotEmpty extends CartState {
  final List<ProductEntity> items;
  CartIsNotEmpty({required this.items});
}
class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
