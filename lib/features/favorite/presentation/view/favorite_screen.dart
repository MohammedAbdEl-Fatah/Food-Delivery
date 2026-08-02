import 'package:flutter/material.dart';

import '../widget/empty_favorite_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  //TODO give name prduct and image and price and add to cart button
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: EmptyFavoriteWidget());
  }
}
