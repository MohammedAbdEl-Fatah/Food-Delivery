import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartEmpty());

  final List<ProductEntity> _items = [];

  List<ProductEntity> get items => List.unmodifiable(_items);

  void addProductToCart(ProductEntity item) {
    _items.add(item);
    _emitCartState();
  }

  void removeProductFromCart(ProductEntity item) {
    _items.remove(item);
    _emitCartState();
  }

  void _emitCartState() {
    if (_items.isEmpty) {
      emit(CartEmpty());
    } else {
      emit(CartIsNotEmpty(items: List.unmodifiable(_items)));
    }
  }
}
