import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartEmpty());

  final List<ProductEntity> _items = [];

  /// index in `_items` -> that item's current total (price * quantity),
  /// reported up from each item's own PriceCubit.
  final Map<int, int> _itemTotals = {};

  double _discountPercent = 0;

  static const double deliveryFee = 0; // Free delivery for now

  List<ProductEntity> get items => List.unmodifiable(_items);

  void addProductToCart(ProductEntity item) {
    _items.add(item);
    _itemTotals[_items.length - 1] = item.price.toInt();
    _emitCartState();
  }

  void removeProductFromCart(ProductEntity item) {
    final index = _items.indexOf(item);
    _items.remove(item);
    if (index != -1) {
      // Rebuild the totals map so indices stay aligned with `_items`
      // after a removal shifts everything down by one.
      final rebuilt = <int, int>{};
      _itemTotals.forEach((i, total) {
        if (i < index) {
          rebuilt[i] = total;
        } else if (i > index) {
          rebuilt[i - 1] = total;
        }
      });
      _itemTotals
        ..clear()
        ..addAll(rebuilt);
    }
    _emitCartState();
  }

  /// Called by each item's PriceCubit whenever its quantity/total changes,
  /// so the cart-level total always stays in sync.
  void updateItemTotal(int index, int total) {
    _itemTotals[index] = total;
    _emitCartState();
  }

  /// Very simple placeholder promo logic — swap in real validation
  /// (e.g. an API call) when you have one.
  void applyPromoCode(String code) {
    _discountPercent = code.trim().toUpperCase() == 'SAVE10' ? 0.10 : 0;
    _emitCartState();
  }

  int get _subtotal =>
      _itemTotals.values.fold(0, (sum, price) => sum + price);

  void _emitCartState() {
    if (_items.isEmpty) {
      emit(CartEmpty());
    } else {
      final subtotal = _subtotal;
      final discountAmount = subtotal * _discountPercent;
      emit(
        CartIsNotEmpty(
          items: List.unmodifiable(_items),
          subtotal: subtotal,
          discountAmount: discountAmount,
          deliveryFee: deliveryFee,
          total: subtotal - discountAmount + deliveryFee,
        ),
      );
    }
  }
}