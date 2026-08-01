import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../layout/cubit/layout_cubit.dart';
import '../widget/empty_favorite_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  //TODO give name prduct and image and price and add to cart button
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: EmptyFavoriteWidget());
  }
}
