import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/servier_locator.dart';
import '../../../cart/presentation/views/cart.dart';
import '../../../home/presentation/view/home_page.dart';
import '../../../profile/presentation/cubit/info_profile_cubit.dart';
import '../../../profile/presentation/views/profile_page.dart';
import '../cubit/change_page_cubit.dart';
import '../widget/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangePageCubit()),

        BlocProvider(create: (context) => sl<InfoProfileCubit>()..getProfile()),
      ],
      child: BlocConsumer<ChangePageCubit, int>(
        listener: (context, index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        builder: (context, stateIndex) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged:
                  (index) => context.read<ChangePageCubit>().changePage(index),
              children: const [
                HomePage(), // Your actual pages
                CartPage(),
                ProfilePage(),
              ],
            ),
            // Using your custom widget here
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: stateIndex,
              onTap: (index) {
                context.read<ChangePageCubit>().changePage(index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
