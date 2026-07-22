import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/home/domain/repository/products_repostiry.dart';

import '../../../../core/model/product_model.dart';

class GetAllProduct {
  final ProductsRepostiry _productsRepostiry;
  GetAllProduct(this._productsRepostiry);
  Future<Either<Failure, List<ProductEntity>>> call() {
    return _productsRepostiry.getAllProducts();
  }
}
