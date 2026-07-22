import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.cubit.dart';
import 'package:food_delivery/features/home/presentation/widget/custom_grid_view_builder.dart';

import '../../../../core/style/app_text_style.dart';
import '../../../../core/widget/loading.dart';
import '../cubit/product/product.status.dart';

class AllProductView extends StatefulWidget {
  const AllProductView({super.key});

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          foregroundColor: ColorManager.grey,
          bottomOpacity: 1,
          title:
              isSearch
                  ? TextField(
                    onChanged: (value) {
                      context.read<ProductCubit>().searchProduct(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Search food...",
                      border: InputBorder.none,
                    ),
                  )
                  : Text(
                    ' All Food',
                    style: AppTextStyle.header5.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary,
                    ),
                  ),
          actions: [
            IconButton(
              icon: isSearch ? const Icon(Icons.close) : const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocBuilder<ProductCubit, ProductStatus>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Loading();
              }
              if (state is ProductSuccess) {
                final products = state.products;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12,
                  ),
                  child: CustomGridViewBuilder(
                    products: products,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              }
              if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
