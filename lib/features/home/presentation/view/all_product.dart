import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/servier_locator.dart';
import '../cubit/product/product_cubit.dart';
import 'all_product_view.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..getAllProducts(),
      child: const AllProductView(),
    );
  }
}
