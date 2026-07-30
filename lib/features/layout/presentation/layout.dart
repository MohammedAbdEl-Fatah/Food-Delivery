import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../core/Colors/color_manager.dart';
import '../cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          final layoutCubit = context.read<LayoutCubit>();
          return Scaffold(
            body: layoutCubit.screen[layoutCubit.currentIndex],
            extendBody: true,
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: layoutCubit.currentIndex,
                onTap: (value) {
                  layoutCubit.changeIndex(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_sharp),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: 'Profile',
                  ),
                ],
                iconSize: 32,
                selectedItemColor: ColorManager.primary,
                selectedFontSize: 28,
                unselectedItemColor: ColorManager.grey,
                unselectedFontSize: 21,
                selectedLabelStyle: AppTextStyle.bodyLarge,
                unselectedLabelStyle: AppTextStyle.bodyMedium,
                backgroundColor: ColorManager.white,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
