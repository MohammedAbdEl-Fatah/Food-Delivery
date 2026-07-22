import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/cubit/cart_cubit.dart';

import '../../../home/presentation/cubit/price/price.cubit.dart';
import '../widget/cart_empty_view.dart';
import '../widget/cart_is_not_empty.dart';
import '../widget/info_location.dart';
import '../widget/promo_code_field.dart';
import '../widget/result_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartEmpty) {
              return const CartEmptyView();
            } else if (state is CartIsNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const InfoLocation(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    const PromoCodeField(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create:
                              (context) => PriceCubit(
                                price: state.items[index].price.toInt(),
                              ),
                          child: CartItemsView(items: [state.items[index]]),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.008),
                    const ResultCart(),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
