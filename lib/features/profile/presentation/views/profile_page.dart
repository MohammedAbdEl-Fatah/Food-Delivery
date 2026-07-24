import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/profile/data/sources/profile_static_data.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';
import 'package:food_delivery/features/profile/presentation/widget/delete_account.dart';

import '../widget/log_out_button.dart';
import '../widget/profile_profile_and_info.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("build");
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            children: [
              _appBar(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              // todo stack ::::::::image edit photo
              const PhotoProfileAndInfo(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Profile",
                  style: AppTextStyle.header6.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
              ...List.generate(
                ProfileStaticData.listProfile.length,
                (index) => _profile(
                  title: ProfileStaticData.listProfile[index].title,
                  icon: ProfileStaticData.listProfile[index].icon,
                  ontap: () async {
                    //switch
                    switch (index) {
                      case 0:
                        log("edit profile page");
                        final isUpdated = await Navigator.pushNamed(
                          context,
                          ContentsRouter.editProfilePage,
                        );
                        if (isUpdated == true) {
                          // Refresh profile data if needed
                          log("Profile updated successfully");
                          if (context.mounted) {
                            context.read<InfoProfileCubit>().clearCache();
                            context.read<InfoProfileCubit>().getProfile();
                          }
                        }
                        break;
                      case 1:
                        Navigator.pushNamed(context, '/address_page');
                        break;
                      case 2:
                        Navigator.pushNamed(context, '/payment_page');
                        break;
                      default:
                    }
                  },
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Support",
                  style: AppTextStyle.header6.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
              ...List.generate(
                ProfileStaticData.listSupport.length,
                (index) => _profile(
                  title: ProfileStaticData.listSupport[index].title,
                  icon: ProfileStaticData.listSupport[index].icon,
                  ontap: () {
                    log(index.toString());
                    switch (index) {
                      case 0:
                        // TODO: Handle this case.
                        break;
                      case 1:
                        // delete account
                        log('delete');
                        showDialog(
                          context: context,
                          builder: (_) => const DeleteAccount(),
                        );
                        break;
                      case 2:
                        break;

                      default:
                    }
                  },
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Text(
        "Profile Settings",
        style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _profile({
    required String title,
    required IconData icon,
    VoidCallback? ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: Icon(icon, size: 21),
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        trailing: const Icon(FontAwesomeIcons.angleRight),
      ),
    );
  }
}
