import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.status.dart';

import '../../../../../core/utils/error/failures.dart';
import '../../../domain/usecase/get_all_product.dart';
import '../../../domain/usecase/get_product_by_category.dart';

class ProductCubit extends Cubit<ProductStatus> {
  ProductCubit(this._getAllProduct, this._getProductByCategory)
    : super(ProductInit());

  final GetAllProduct _getAllProduct;
  final GetProductByCategory _getProductByCategory;
  List<ProductEntity> _allProducts = [];

  Future<void> _loadProducts(
    Future<Either<Failure, List<ProductEntity>>> Function() loader,
  ) async {
    emit(ProductLoading());

    final result = await loader();

    result.fold((failure) => emit(ProductError(message: failure.message)), (
      product,
    ) {
      _allProducts = product;
      emit(ProductSuccess(products: product));
    });
  }

  //1-method get all products
  Future<void> getAllProducts() async {
    try {
      emit(ProductLoading());
      await _loadProducts(() => _getAllProduct());
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  //2-method get products by category
  Future<void> getProductsByCategory(String category) async {
    try {
      emit(ProductLoading());
      await _loadProducts(() => _getProductByCategory(category));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      emit(ProductSuccess(products: _allProducts));
      return;
    }

    final filtered =
        _allProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

    emit(ProductSuccess(products: filtered));
  }
}
