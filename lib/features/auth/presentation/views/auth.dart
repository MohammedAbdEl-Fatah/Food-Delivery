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
        } else {
          if (snapshot.data?.uid != null) {
            return const LayoutScreen();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
