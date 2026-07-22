part of 'cart_cubit.dart';

sealed class CartState {}
class CartEmpty extends CartState {}
class CartSwitchLoading extends CartState {}
class CartIsNotEmpty extends CartState {
  final List<ProductEntity> items;
  final int subtotal;
  final double discountAmount;
  final double deliveryFee;
  final double total;

  CartIsNotEmpty({
    required this.items,
    required this.subtotal,
    required this.discountAmount,
    required this.deliveryFee,
    required this.total,
  });
}
class CartError extends CartState {
  final String message;
  CartError({required this.message});
}