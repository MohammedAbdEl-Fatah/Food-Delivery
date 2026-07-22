import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/images.dart';
import '../../../../core/style/app_text_style.dart';
import '../../../botton_nav_bar/presentation/cubit/change_page_cubit.dart';

class CartEmptyView extends StatelessWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
          //image
          Image.asset(
            ImageResources.emptyCart,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.3,
          ),
          //text header
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
          Text(
            "Ouch! Hungry",
            style: AppTextStyle.header5.copyWith(fontWeight: FontWeight.bold),
          ),
          //subtext header
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
          Text(
            "Seems like you have not ordered any food yet",
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          //serach button /=> back to home ^_^
          ElevatedButton(
            onPressed: () {
              context.read<ChangePageCubit>().changePage(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.25,
              ),
              elevation: 0,
            ),
            child: Text(
              'Find Foods',
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
