import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';
import 'package:food_delivery/features/profile/presentation/widget/profile_avatar.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';

class PhotoProfileAndInfo extends StatelessWidget {
  const PhotoProfileAndInfo({super.key});

  static const double _avatarRadius = 44;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoProfileCubit, InfoProfileState>(
      builder: (context, state) {
        if (state is InfoProfileLoading) {
          return const Center(child: Loading());
        } else if (state is InfoProfileFialure) {
          return Center(
            child: Text(
              'Could not load profile',
              style: AppTextStyle.bodyLarge.copyWith(color: ColorManager.grey),
            ),
          );
        } else if (state is InfoProfileSuccess) {
          final user = state.userModel;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileAvatar(
                photoUrl: user.photoUrl,
                gender: user.gender,
                radius: _avatarRadius,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name.isNotEmpty ? user.name : 'Add your name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.header6.copyWith(
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email.isNotEmpty ? user.email : 'Add your email',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: ColorManager.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
