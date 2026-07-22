import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/features/home/domain/repository/products_repostiry.dart';

import '../../../../core/service/firebase_store_service.dart';
import '../../../../core/utils/error/failures.dart';

class ProductsRepositoryImpl extends ProductsRepostiry {
  final FirebaseStoreService<ProductEntity> _productService;
  ProductsRepositoryImpl(this._productService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    //1- using service of firestoe
    try {
      final result = await _productService.getAll();
      //2- filter all products not has null
      final List<ProductEntity> productModel =
          result.whereType<ProductEntity>().toList();
      //return all products
      return right(productModel);
    } on Exception catch (e) {
      // return if there some error
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    String category,
  ) async {
    try {
      //using service of firestoe
      final result = await _productService.getManyByCategory(category);
      //filter products by category
      final List<ProductEntity> productModel =
          result.whereType<ProductEntity>().toList();
      //return products
      return right(productModel);
    } on Exception catch (e) {
      //return if there some error
      return left(FirebaseFailure(e.toString()));
    }
  }
}
