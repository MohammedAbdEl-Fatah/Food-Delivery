import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/core/storage/shared_preference.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/profile/presentation/widget/edit_text_profile.dart';

import '../../../../core/di/servier_locator.dart';
import '../../../../core/style/app_text_style.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/info_profile_cubit.dart';
import '../widget/gender_drop_down.dart';
import '../widget/profile_profile_and_info.dart';

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

  String originalName = '';
  String originalEmail = '';
  String originalPhone = '';
  String originalBirthDate = '';
  String originalGender = '';

  @override
  void initState() {
    super.initState();

    // Listen for changes in text fields
    nameController.addListener(_checkForChanges);
    emailController.addListener(_checkForChanges);
    phoneController.addListener(_checkForChanges);
    birthController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    nameController.removeListener(_checkForChanges);
    emailController.removeListener(_checkForChanges);
    phoneController.removeListener(_checkForChanges);
    birthController.removeListener(_checkForChanges);

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthController.dispose();
    genderController.dispose();
    ageController.dispose();

    super.dispose();
  }

  /// Checks whether the user changed any profile data.
  bool get hasChanges {
    return nameController.text != originalName ||
        emailController.text != originalEmail ||
        phoneController.text != originalPhone ||
        birthController.text != originalBirthDate ||
        genderController.text != originalGender;
  }

  void _checkForChanges() {
    if (!mounted) return;

    setState(() {});
  }

  /// Set the original values after loading the profile.
  void _setOriginalValues(UserModel user) {
    final birthDate =
        user.birthday.contains('T')
            ? user.birthday.substring(0, user.birthday.indexOf('T'))
            : user.birthday;

    // Set controllers
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone ?? '';
    birthController.text = birthDate;
    genderController.text = user.gender;
    ageController.text = user.age.toString();

    // Save original values
    originalName = user.name;
    originalEmail = user.email;
    originalPhone = user.phone ?? '';
    originalBirthDate = birthDate;
    originalGender = user.gender;

    // At this point nothing has been changed by the user.
    isUpdated = false;
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
            'Personal Data',
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.black,
            ),
          ),

          centerTitle: true,
        ),

        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<InfoProfileCubit>()..getProfile()),
            BlocProvider(create: (_) => sl<EditProfileCubit>()),
          ],

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PhotoProfileAndInfo(),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),

                  BlocListener<InfoProfileCubit, InfoProfileState>(
                    listener: (context, state) {
                      if (state is InfoProfileSuccess) {
                        _setOriginalValues(state.userModel);
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
                            // =========================
                            // Name
                            // =========================
                            EditTextPrpfile(
                              text: "Full Name",
                              controller: nameController,
                              hintText: user?.name ?? "",
                            ),

                            // =========================
                            // Email
                            // =========================
                            EditTextPrpfile(
                              text: "Email",
                              controller: emailController,
                              hintText: user?.email ?? "",
                            ),

                            // =========================
                            // Phone
                            // =========================
                            EditTextPrpfile(
                              text: "Phone",
                              controller: phoneController,
                              hintText: user?.phone ?? "No Phone",
                            ),

                            // =========================
                            // Birth Date
                            // =========================
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

                            // =========================
                            // Gender
                            // =========================
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
        final bool canSave = hasChanges && state is! EditProfileLoading;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),

            elevation: canSave ? 3 : 0,

            //Note: Active = primary
            // Disabled = gray
            backgroundColor:
                canSave ? ColorManager.primary : Colors.grey.shade400,

            foregroundColor: ColorManager.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),

          // null = disabled
          onPressed:
              canSave
                  ? () {
                    log("Saving profile...");

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
                    Navigator.pop(context, isUpdated);
                    log("isUpdated: $isUpdated");
                  }
                  : null,

          child:
              state is EditProfileLoading
                  ? const Loading()
                  : const Text('Save', style: AppTextStyle.bodyLarge),
        );
      },
    );
  }
}
