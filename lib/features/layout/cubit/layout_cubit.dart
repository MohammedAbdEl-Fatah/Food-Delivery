import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/views/cart.dart';
import 'package:food_delivery/features/home/presentation/view/home_page.dart';
import 'package:food_delivery/features/profile/presentation/views/profile_page.dart';

// import '../../../favorite/presentation/view/favortire_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitLayoutState());

  int currentIndex = 0;
  List<Widget> screen = const [
    HomePage(),
    CartPage(),
    ProfilePage(),
    // FavortireScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeLayoutState());
  }
}
