import '../../../../../core/model/product_model.dart';

sealed class ProductStatus {}

class ProductInit extends ProductStatus {}

class ProductLoading extends ProductStatus {}

class ProductSuccess extends ProductStatus {
  final List<ProductEntity> products;
  ProductSuccess({required this.products});
}

class ProductError extends ProductStatus {
  final String message;
  ProductError({required this.message});
}
