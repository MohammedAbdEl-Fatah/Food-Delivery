import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/images.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.photoUrl,
    this.gender = '',
    this.radius = 44,
  });

  final String? photoUrl;
  final String gender;
  final double radius;

  bool get _hasPhoto => photoUrl != null && photoUrl!.trim().isNotEmpty;

  bool get _hasGender => gender == 'male' || gender == 'female';

  @override
  Widget build(BuildContext context) {
    if (_hasPhoto) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: photoUrl!.trim(),
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (_, __) => _personIconAvatar(),
          errorWidget: (_, __, ___) => _genderOrPersonAvatar(),
        ),
      );
    }

    return _genderOrPersonAvatar();
  }

  Widget _genderOrPersonAvatar() {
    if (_hasGender) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: ColorManager.grey.withAlpha((255 * 0.2).toInt()),
        backgroundImage: AssetImage(
          gender == 'male'
              ? AnimationResources.maleAvater
              : AnimationResources.femaleAvatar,
        ),
      );
    }

    return _personIconAvatar();
  }

  Widget _personIconAvatar() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
      child: Icon(
        Icons.person_rounded,
        size: radius * 1.15,
        color: ColorManager.primary,
      ),
    );
  }
}
