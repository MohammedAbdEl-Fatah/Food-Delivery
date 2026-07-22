import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/product_model.dart';

import '../../../../core/utils/error/failures.dart';

abstract class ProductsRepostiry {
  Future<Either<Failure, List<ProductEntity>>> getProducts(String category);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
