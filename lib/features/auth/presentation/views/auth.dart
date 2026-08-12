import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/widget/loading.dart';
import 'package:food_delivery/features/auth/log_in/presentation/view/login.dart';
// import 'package:food_delivery/features/botton_nav_bar/presentation/views/main_page.dart';

import '../../../layout/presentation/layout.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(child: Center(child: Loading()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        }

        final user = snapshot.data;
        if (user == null) {
          return const LoginScreen();
        }

        final isGoogleSignIn = user.providerData.any(
          (provider) => provider.providerId == 'google.com',
        );
        if (isGoogleSignIn) {
          return const LayoutScreen();
        }

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream:
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Material(child: Center(child: Loading()));
            }

            final userData = userSnapshot.data?.data();
            final isEmailConfirmed = userData?['confrimEmail'] == true;
            final isGoogleUser = userData?['provider'] == 'google';

            if (isEmailConfirmed || isGoogleUser) {
              return const LayoutScreen();
            }

            return const LoginScreen();
          },
        );
      },
    );
  }
}
