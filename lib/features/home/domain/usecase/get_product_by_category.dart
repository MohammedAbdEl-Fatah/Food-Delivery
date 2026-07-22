import 'package:dartz/dartz.dart';
import 'package:food_delivery/features/home/domain/repository/products_repostiry.dart';

import '../../../../core/model/product_model.dart';
import '../../../../core/utils/error/failures.dart';

class GetProductByCategory {
  final ProductsRepostiry _productsRepostiry;

  GetProductByCategory(this._productsRepostiry);

  Future<Either<Failure, List<ProductEntity>>> call(String category) {
    return _productsRepostiry.getProducts(category);
  }
}
