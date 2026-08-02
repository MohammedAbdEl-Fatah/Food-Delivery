import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/favorite/presentation/cubit/favorite_cubit.dart';

import '../widget/empty_favorite_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  //TODO give name prduct and image and price and add to cart button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          log(context.read<FavoriteCubit>().state.items.length.toString());
          if (state.items.isNotEmpty) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index];
                return ListTile(
                  leading: Image.network(product.urlImage ?? ''),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      context.read<FavoriteCubit>().removeFavorite(product);
                    },
                  ),
                );
              },
            );
          } else {
            return const EmptyFavoriteWidget();
          }
        },
      ),
    );
  }
}
