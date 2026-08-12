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
  DateTime loadedCreatedAt = DateTime.now();

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

  String _displayPhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return '';
    return phone.trim();
  }

  String _phoneForSave(String phone) {
    return phone.trim();
  }

  String _birthHint(String? birthday) {
    if (birthday == null || birthday.trim().isEmpty) {
      return 'e.g. 2000-01-15';
    }
    if (birthday.contains('T')) {
      return birthday.substring(0, birthday.indexOf('T'));
    }
    return birthday;
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
    phoneController.text = _displayPhone(user.phone);
    birthController.text = birthDate;
    genderController.text = user.gender;
    ageController.text = user.age.toString();

    // Save original values
    originalName = user.name;
    originalEmail = user.email;
    originalPhone = _displayPhone(user.phone);
    originalBirthDate = birthDate;
    originalGender = user.gender;
    loadedCreatedAt = user.createdAt;

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
            'Personal Information',
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

          child: BlocListener<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                isUpdated = true;
                Navigator.pop(context, true);
              } else if (state is EditProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
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
                            EditTextProfile(
                              text: "Full Name",
                              controller: nameController,
                              hintText:
                                  (user?.name ?? '').isEmpty
                                      ? 'Enter your full name'
                                      : user!.name,
                            ),

                            // =========================
                            // Email
                            // =========================
                            EditTextProfile(
                              text: "Email",
                              controller: emailController,
                              hintText:
                                  (user?.email ?? '').isEmpty
                                      ? 'Enter your email'
                                      : user!.email,
                            ),

                            // =========================
                            // Phone
                            // =========================
                            EditTextProfile(
                              text: "Phone",
                              controller: phoneController,
                              hintText:
                                  _displayPhone(user?.phone).isEmpty
                                      ? 'Add your phone number'
                                      : _displayPhone(user?.phone),
                            ),

                            // =========================
                            // Birth Date
                            // =========================
                            EditTextProfile(
                              text: "Birth Date",
                              controller: birthController,
                              hintText:
                                  _birthHint(user?.birthday).isEmpty
                                      ? 'Add your birth date (YYYY-MM-DD)'
                                      : _birthHint(user?.birthday),
                            ),

                            // =========================
                            // Gender
                            // =========================
                            GenderDropDown(
                              selectedGender: genderController.text,
                              hintText: 'Select your gender',

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
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: _phoneForSave(phoneController.text),
                        birthday: birthController.text.trim(),
                        gender: genderController.text.trim(),
                        createdAt: loadedCreatedAt,
                        id: AppPreferences.instance.getString(
                          key: SharedPreferenceKey.userId,
                        ),
                        age: int.tryParse(ageController.text) ?? 0,
                      ),
                    );
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
