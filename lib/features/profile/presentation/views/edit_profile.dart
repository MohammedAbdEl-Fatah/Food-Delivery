import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/core/storage/shared_preference.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/profile/presentation/widget/edit_text_profile.dart';

import '../../../../core/contents/images.dart';
import '../../../../core/di/servier_locator.dart';
import '../../../../core/style/app_text_style.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/info_profile_cubit.dart';
import '../widget/gender_drop_down.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isUpdated = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthController.dispose();
    genderController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isUpdated);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          backgroundColor: ColorManager.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context, isUpdated);
            },
          ),
          title: Text(
            'Personal Date',
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.black,
            ),
          ),
          centerTitle: true,
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<InfoProfileCubit>(
              create: (_) => sl<InfoProfileCubit>()..getProfile(),
            ),
            BlocProvider<EditProfileCubit>(
              create: (_) => sl<EditProfileCubit>(),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 3,
                    minRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 1,
                    // radius: 50,
                    //todo connect image by device or give for firebase if not null
                    backgroundImage: const AssetImage(ImageResources.drink),

                    // child: Text(
                    //   "M",
                    //   style: AppTextStyle.header4.copyWith(
                    //     fontWeight: FontWeight.bold,
                    //     color: ColorManager.black,
                    //   ),
                    // ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),

                  BlocListener<InfoProfileCubit, InfoProfileState>(
                    listener: (context, state) {
                      if (state is InfoProfileSuccess) {
                        final user = state.userModel;

                        nameController.text = user.name;
                        emailController.text = user.email;
                        phoneController.text = user.phone ?? "";
                        birthController.text =
                            user.birthday.contains('T')
                                ? user.birthday.substring(
                                  0,
                                  user.birthday.indexOf('T'),
                                )
                                : user.birthday;
                        genderController.text = user.gender;
                        ageController.text = user.age.toString();
                      }
                    },
                    child: BlocBuilder<InfoProfileCubit, InfoProfileState>(
                      builder: (context, state) {
                        final UserModel? user =
                            state is InfoProfileSuccess
                                ? state.userModel
                                : null;

                        return Column(
                          children: [
                            EditTextPrpfile(
                              text: "Full Name",
                              controller: nameController,
                              hintText: user?.name ?? "",
                            ),
                            EditTextPrpfile(
                              text: "Email",
                              controller: emailController,
                              hintText: user?.email ?? "",
                            ),
                            EditTextPrpfile(
                              text: "Phone",
                              controller: phoneController,
                              hintText: user?.phone ?? "No Phone",
                            ),
                            EditTextPrpfile(
                              text: "Birth Date",
                              controller: birthController,
                              hintText:
                                  user == null
                                      ? ""
                                      : (user.birthday.contains('T')
                                          ? user.birthday.substring(
                                            0,
                                            user.birthday.indexOf('T'),
                                          )
                                          : user.birthday),
                            ),
                            GenderDropDown(
                              selectedGender: genderController.text,
                              onChange: (gender) {
                                setState(() {
                                  genderController.text = gender ?? '';
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
            elevation: 3,
            backgroundColor: ColorManager.primary,
            foregroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            // TODO: Implement save functionality
            log("save");
            context.read<EditProfileCubit>().updateProfile(
              UserModel(
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                birthday: birthController.text,
                gender: genderController.text,
                createdAt: DateTime.now(),
                id: AppPreferences.instance.getString(
                  key: SharedPreferenceKey.userId,
                ),
                age: int.tryParse(ageController.text) ?? 0,
              ),
            );
            isUpdated = true;
            setState(() {});
            log("isUpdated: $isUpdated");
          },
          child:
              state is EditProfileLoading
                  ? const Loading()
                  : const Text('Save', style: AppTextStyle.bodyLarge),
        );
      },
    );
  }
}
