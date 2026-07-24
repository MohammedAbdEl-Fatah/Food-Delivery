import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/style/app_text_style.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Account',
        style: AppTextStyle.header4.copyWith(
          color: ColorManager.error,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete your account?',
        style: AppTextStyle.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: AppTextStyle.bodyMedium.copyWith(color: ColorManager.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            //TODO delete account
            log('Delete account');
          },
          child: Text(
            'Delete',
            style: AppTextStyle.bodyMedium.copyWith(color: ColorManager.error),
          ),
        ),
      ],
    );
  }
}
