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
          return Column(
            children: [
              CircleAvatar(
                maxRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 3,
                minRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 1,
                // radius: 50,
                //todo connect image by device or give for firebase if not null
                backgroundImage:const AssetImage(ImageResources.drink),

                // child: Text(
                //   "M",
                //   style: AppTextStyle.header4.copyWith(
                //     fontWeight: FontWeight.bold,
                //     color: ColorManager.black,
                //   ),
                // ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
              Text(
                state.userModel.name,
                style: AppTextStyle.header6.copyWith(
                  color: ColorManager.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.001),
              Text(
                state.userModel.email,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: ColorManager.grey,
                  fontWeight: FontWeight.w500,
                ),
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
