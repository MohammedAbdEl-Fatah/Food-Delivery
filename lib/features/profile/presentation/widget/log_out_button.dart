import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/enum.dart';
import '../../../../core/router/contents_router.dart';
import '../../../../core/storage/shared_preference.dart';
import '../../../../core/style/app_text_style.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Show confirmation dialog
        showDialog(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                title: Text(
                  'Sign Out',
                  style: AppTextStyle.header4.copyWith(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: Text(
                  'Are you sure you want to sign out?',
                  style: AppTextStyle.bodyLarge.copyWith(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: ColorManager.error,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Sign out from Firebase
                      await FirebaseAuth.instance.signOut();
    
                      // Clear all local data from SharedPreferences
                      //!Fix this line : onboarding data still there after sign out
    
                      await AppPreferences.instance.clear();
                      await AppPreferences.instance.setBool(
                        key: SharedPreferenceKey.seenOnBoarding,
                        value: true,
                      );
                      // Navigate to login page (adjust route name based on your navigation)
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ContentsRouter.login, // Change to your login route
                          (route) => false,
                        );
                      }
                    },
                    child: Text(
                      'Sign Out',
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: ColorManager.green,
                      ),
                    ),
                  ),
                ],
              ),
        );
      },
      style: ElevatedButton.styleFrom(
        splashFactory: InkSplash.splashFactory,
        backgroundColor: Colors.transparent,
        elevation: 0,
        side: BorderSide(color: ColorManager.grey.withAlpha(60)),
        overlayColor: Colors.cyan.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.arrowRightFromBracket,
            color: ColorManager.error,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Sign Out',
              style: AppTextStyle.bodyLarge.copyWith(
                color: ColorManager.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
