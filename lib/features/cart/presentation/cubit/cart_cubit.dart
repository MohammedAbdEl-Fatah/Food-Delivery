import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartEmpty());

  final List<ProductEntity> _items = [];

  /// product.title -> quantity in the cart
  final Map<String, int> _quantities = {};

  /// index in `_items` -> that item's current total (price * quantity)
  final Map<int, int> _itemTotals = {};

  double _discountPercent = 0;

  static const double deliveryFee = 0; // Free delivery for now

  List<ProductEntity> get items => List.unmodifiable(_items);

  int quantityOf(String productId) => _quantities[productId] ?? 0;

  void addProductToCart(ProductEntity item, {int quantity = 1}) {
    final addBy = quantity < 1 ? 1 : quantity;
    final existingIndex = _items.indexWhere((product) => product.title == item.title);

    if (existingIndex != -1) {
      final nextQuantity = (_quantities[item.title] ?? 1) + addBy;
      _quantities[item.title] = nextQuantity;
      _itemTotals[existingIndex] = item.price.toInt() * nextQuantity;
    } else {
      _items.add(item);
      _quantities[item.title] = addBy;
      _itemTotals[_items.length - 1] = item.price.toInt() * addBy;
    }
    _emitCartState();
  }

  void removeProductFromCart(ProductEntity item) {
    final index = _items.indexWhere((product) => product.title == item.title);
    if (index == -1) return;

    _items.removeAt(index);
    _quantities.remove(item.title);

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

    _emitCartState();
  }

  /// Called by each item's PriceCubit whenever its quantity/total changes,
  /// so the cart-level total always stays in sync.
  void updateItemTotal(int index, int total) {
    if (index < 0 || index >= _items.length) return;

    final item = _items[index];
    final unitPrice = item.price.toInt();
    final quantity = unitPrice == 0 ? 1 : (total / unitPrice).round().clamp(1, 999);

    _quantities[item.title] = quantity;
    _itemTotals[index] = unitPrice * quantity;
    _emitCartState();
  }

  void applyPromoCode(String code) {
    _discountPercent = code.trim().toUpperCase() == 'SAVE10' ? 0.10 : 0;
    _emitCartState();
  }

  int get _subtotal => _itemTotals.values.fold(0, (sum, price) => sum + price);

  void _emitCartState() {
    if (_items.isEmpty) {
      emit(CartEmpty());
    } else {
      final subtotal = _subtotal;
      final discountAmount = subtotal * _discountPercent;
      emit(
        CartIsNotEmpty(
          items: List.unmodifiable(_items),
          quantities: Map.unmodifiable(_quantities),
          subtotal: subtotal,
          discountAmount: discountAmount,
          deliveryFee: deliveryFee,
          total: subtotal - discountAmount + deliveryFee,
        ),
      );
    }
  }

  void clearCart() {
    _items.clear();
    _quantities.clear();
    _itemTotals.clear();
    _discountPercent = 0;
    emit(CartEmpty());
  }
}
