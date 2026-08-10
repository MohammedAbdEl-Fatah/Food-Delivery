import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/favorite/presentation/cubit/favorite_cubit.dart';

import '../../../../core/router/contents_router.dart';
import '../widget/empty_favorite_widget.dart';
import '../widget/grid_iteam.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          log(context.read<FavoriteCubit>().state.items.length.toString());
          if (state.items.isNotEmpty) {
            //TODO : Implement the UI for displaying favorite items

            return GridView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ContentsRouter.detailsCard,
                      arguments: product,
                    );
                  },
                  child: GridIteam(product: product),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            );
          } else {
            return const EmptyFavoriteWidget();
          }
        },
      ),
    );
  }
}
