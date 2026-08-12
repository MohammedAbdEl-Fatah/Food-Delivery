import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';

import '../../../../core/Colors/color_manager.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({super.key});

  bool _isEmpty(String? value) => value == null || value.trim().isEmpty;

  String _formatBirthday(String birthday) {
    if (_isEmpty(birthday)) return '';
    return birthday.contains('T')
        ? birthday.substring(0, birthday.indexOf('T'))
        : birthday;
  }

  String _formatGender(String gender) {
    if (_isEmpty(gender)) return '';
    return gender[0].toUpperCase() + gender.substring(1);
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final isUpdated = await Navigator.pushNamed(
      context,
      ContentsRouter.editProfilePage,
    );
    if (isUpdated == true && context.mounted) {
      context.read<InfoProfileCubit>().clearCache();
      context.read<InfoProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoProfileCubit, InfoProfileState>(
      builder: (context, state) {
        if (state is! InfoProfileSuccess) {
          return const SizedBox.shrink();
        }

        final user = state.userModel;
        final missingCount =
            [user.phone, user.birthday, user.gender].where(_isEmpty).length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (missingCount > 0) ...[
              _CompleteProfileBanner(
                missingCount: missingCount,
                onTap: () => _openEditProfile(context),
              ),
              const SizedBox(height: 12),
            ],
            _DetailTile(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: user.phone,
              emptyHint: 'Add your phone number',
              onTap: () => _openEditProfile(context),
            ),
            _DetailTile(
              icon: Icons.cake_outlined,
              label: 'Birth date',
              value: _formatBirthday(user.birthday),
              emptyHint: 'Add your birth date',
              onTap: () => _openEditProfile(context),
            ),
            _DetailTile(
              icon: Icons.person_outline,
              label: 'Gender',
              value: _formatGender(user.gender),
              emptyHint: 'Select your gender',
              onTap: () => _openEditProfile(context),
            ),
          ],
        );
      },
    );
  }
}

class _CompleteProfileBanner extends StatelessWidget {
  const _CompleteProfileBanner({
    required this.missingCount,
    required this.onTap,
  });

  final int missingCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: ColorManager.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  missingCount == 1
                      ? 'Complete your profile — 1 field missing'
                      : 'Complete your profile — $missingCount fields missing',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: ColorManager.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.emptyHint,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final String emptyHint;
  final VoidCallback onTap;

  bool get _hasValue => value != null && value!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: ColorManager.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: ColorManager.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _hasValue ? value!.trim() : emptyHint,
                    style: AppTextStyle.bodyLarge.copyWith(
                      color:
                          _hasValue
                              ? ColorManager.black
                              : ColorManager.grey.withValues(alpha: 0.85),
                      fontStyle:
                          _hasValue ? FontStyle.normal : FontStyle.italic,
                      fontWeight: _hasValue ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
