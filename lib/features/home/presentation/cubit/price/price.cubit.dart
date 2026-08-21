import 'package:flutter_bloc/flutter_bloc.dart';
part 'price.status.dart';

class PriceCubit extends Cubit<PriceStatus> {
  final int price;
  PriceCubit({required this.price, int quantity = 1})
    : super(
        PriceStatus(
          quantity: quantity < 1 ? 1 : quantity,
          totalprice: price * (quantity < 1 ? 1 : quantity),
        ),
      );

  void incrementPrice() {
    final newQuantity = state.quantity + 1;
    emit(
      state.copyWith(quantity: newQuantity, totalprice: newQuantity * price),
    );
  }

  void decrementPrice() {
    if (state.quantity > 1) {
      final newQuantity = state.quantity - 1;
      emit(
        state.copyWith(quantity: newQuantity, totalprice: price * newQuantity),
      );
    }
  }
}
