import 'package:flutter_bloc/flutter_bloc.dart';
part 'price.status.dart';

class PriceCubit extends Cubit<PriceStatus> {
  final int price;
  PriceCubit({required this.price})
    : super(PriceStatus(quantity: 1, totalprice: price));

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
