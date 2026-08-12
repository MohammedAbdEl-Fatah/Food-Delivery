import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/images.dart';
import '../../../../core/style/app_text_style.dart';

class PhotoProfileAndInfo extends StatelessWidget {
  const PhotoProfileAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoProfileCubit, InfoProfileState>(
      builder: (context, state) {
        if (state is InfoProfileLoading) {
          return const Center(child: Loading());
        } else if (state is InfoProfileFialure) {
          return const SizedBox();
        } else if (state is InfoProfileSuccess) {
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.grey.withAlpha(
                  (255 * 0.45).toInt(),
                ),
                maxRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 4,
                minRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 2,
                backgroundImage: AssetImage(
                  state.userModel.gender == 'male'
                      ? AnimationResources.maleAvater
                      : AnimationResources.femaleAvatar,
                ),
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.header6.copyWith(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.001),
                  Text(
                    state.userModel.email,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: ColorManager.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
