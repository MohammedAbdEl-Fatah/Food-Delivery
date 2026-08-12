import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordException implements Exception {
  ForgotPasswordException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FirebaseForgotPasswordDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const _androidPackageName = 'com.example.food_delivery';
  static const _continueUrl = 'https://food-delivery-5b298.firebaseapp.com';

  Future<void> sendPasswordResetEmail(String email) async {
    final normalizedEmail = email.trim();

    final userSnapshot =
        await _firestore
            .collection('users')
            .where('email', isEqualTo: normalizedEmail)
            .limit(1)
            .get();

    if (userSnapshot.docs.isEmpty) {
      throw ForgotPasswordException(
        'Email not found. Please check your email address.',
      );
    }

    final userData = userSnapshot.docs.first.data();
    final provider = (userData['provider'] as String?)?.toLowerCase() ?? 'email';

    if (provider == 'google') {
      throw ForgotPasswordException(
        'This account uses Google Sign-In. Please log in with Google instead.',
      );
    }

    await _auth.sendPasswordResetEmail(
      email: normalizedEmail,
      actionCodeSettings: ActionCodeSettings(
        url: _continueUrl,
        handleCodeInApp: false,
        androidPackageName: _androidPackageName,
        androidInstallApp: false,
        androidMinimumVersion: '1',
      ),
    );
  }
}
