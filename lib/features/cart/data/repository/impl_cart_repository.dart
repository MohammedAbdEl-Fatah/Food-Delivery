import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/storage/hive_services.dart';
import 'package:food_delivery/features/cart/domain/repository/cart_repository.dart';

class ImplCartRepository implements CartRepository {
  final HiveServices _hiveServices;

  ImplCartRepository(this._hiveServices);

  @override
  void getAll() {
    _hiveServices.getAllData(boxKey: HiveBoxKeys.cart);
  }

  @override
  void add(ProductEntity product) {
    _hiveServices.saveData(
      boxKey: HiveBoxKeys.cart,
      key: product.id,
      value: product,
    );
  }

  @override
  void remove(ProductEntity product) {
    _hiveServices.deleteData(boxKey: HiveBoxKeys.cart, key: product.id);
  }

  @override
  void clear() {
    _hiveServices.clearBox(boxKey: HiveBoxKeys.cart);
  }
}
