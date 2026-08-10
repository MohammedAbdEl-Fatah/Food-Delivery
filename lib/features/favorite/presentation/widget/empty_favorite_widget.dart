
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';
import '../../../layout/cubit/layout_cubit.dart';

class EmptyFavoriteWidget extends StatelessWidget {
  const EmptyFavoriteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2,
          ),
          child: Icon(
            Icons.no_food,
            size: MediaQuery.of(context).size.width * 0.55,
            color: ColorManager.primary,
          ),
        ),
        Text(
          'No Favorite Yet',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          'You have not added any favorite items yet.',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: ColorManager.grey,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        ElevatedButton(
          onPressed: () {
            context.read<LayoutCubit>().changeIndex(0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Go to Home',
            style: AppTextStyle.header6.copyWith(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
