import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/log_in/data/model/user_google.dart';
import 'package:food_delivery/features/auth/log_in/domain/entities/log_in_entity.dart';
import 'package:food_delivery/features/auth/log_in/domain/repository/log_in_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/contents/enum.dart';
import '../../../../../core/storage/shared_preference.dart';

class FirebaseLogInRepository extends LogInRepository {
  static const _googleWebClientId =
      '218086322843-jnlcq061qc9pqlhuibnauh2a4rd6k2hk.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: _googleWebClientId,
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, LogInEntity>> logInEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        return Left(ServerFailure('User not found after sign-in.'));
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      final isEmailConfirmed = userDoc.data()?['confrimEmail'] as bool? ?? false;
      if (!isEmailConfirmed) {
        await _auth.signOut();
        return Left(
          FirebaseFailure('Please verify your email before logging in.'),
        );
      }

      await user.reload();
      AppPreferences.instance.setString(
        key: SharedPreferenceKey.userId,
        value: user.uid,
      );
      return Right(
        LogInEntity(
          id: user.uid,
          name: user.displayName ?? user.email?.split('@').first ?? 'User',
          email: user.email ?? email,
        ),
      );
    } on FirebaseAuthException catch (e, s) {
      log('FirebaseAuthException code: ${e.code}');
      log('FirebaseAuthException message: ${e.message}');
      log('FirebaseAuthException credential: ${e.email}');
      log('StackTrace: $s');
      switch (e.code) {
        case 'user-not-found':
          return Left(FirebaseFailure('No user found with this email.'));
        case 'wrong-password':
          return Left(FirebaseFailure('Incorrect password. Please try again.'));
        case 'invalid-email':
          return Left(FirebaseFailure('The email address is badly formatted.'));
        case 'invalid-credential':
          // This usually indicates the email/password combination is invalid
          // or the credential has expired (for example, for federated providers).
          return Left(FirebaseFailure('The email or password is incorrect.'));
        case 'user-disabled':
          return Left(FirebaseFailure('This user account has been disabled.'));
        case 'too-many-requests':
          return Left(FirebaseFailure('Too many attempts. Try again later.'));
        case 'network-request-failed':
          return Left(FirebaseFailure('Network error. Check your connection.'));
        case 'operation-not-allowed':
          return Left(
            FirebaseFailure('Password sign-in is disabled in Firebase.'),
          );
        default:
          return Left(
            FirebaseFailure(
              'Sign-in failed:,${e.code} & ${e.message ?? 'Unknown error'}',
            ),
          );
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserGoogle>> logInGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(FirebaseFailure('Google sign-in was cancelled.'));
      }

      final authentication = await googleUser.authentication;
      final idToken = authentication.idToken;
      if (idToken == null) {
        return Left(
          FirebaseFailure(
            'Google sign-in failed: missing ID token. Check Firebase Google Sign-In setup.',
          ),
        );
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(FirebaseFailure('Google sign-in failed. Please try again.'));
      }

      // Ensure the auth token is available to Firestore before writing user data.
      await firebaseUser.getIdToken(true);

      await AppPreferences.instance.setString(
        key: SharedPreferenceKey.userId,
        value: firebaseUser.uid,
      );

      final userGoogle = UserGoogle(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? googleUser.displayName ?? '',
        email: firebaseUser.email ?? googleUser.email,
        photoUrl: firebaseUser.photoURL ?? googleUser.photoUrl ?? '',
        gender: '',
        birthday: '',
        createdAt: DateTime.now(),
        phone: firebaseUser.phoneNumber ?? '',
        provider: 'google',
      );

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
              ...userGoogle.toMap(),
              'confrimEmail': true,
            }, SetOptions(merge: true));
      } on FirebaseException catch (e) {
        // Auth succeeded; don't block login if profile sync fails.
        log(
          'Google sign-in succeeded but Firestore sync failed: ${e.code} ${e.message}',
        );
      }

      return Right(userGoogle);
    } on FirebaseAuthException catch (e) {
      log('Google sign-in FirebaseAuthException: ${e.code} ${e.message}');
      return Left(
        FirebaseFailure(
          e.message ?? 'Google sign-in failed (${e.code}). Please try again.',
        ),
      );
    } on PlatformException catch (e) {
      log('Google sign-in PlatformException: ${e.code} ${e.message}');
      return Left(FirebaseFailure(_mapGooglePlatformError(e)));
    } catch (e, s) {
      log('Google sign-in error: $e');
      log('StackTrace: $s');
      return Left(FirebaseFailure('Google sign-in failed: $e'));
    }
  }

  String _mapGooglePlatformError(PlatformException error) {
    final details = error.message ?? '';
    if (details.contains('ApiException: 10') ||
        details.contains('DEVELOPER_ERROR')) {
      return 'Google Sign-In is not configured for this device. '
          'Add your app SHA-1 fingerprint in Firebase Console, '
          'download a new google-services.json, then rebuild the app.';
    }
    if (error.code == 'sign_in_canceled') {
      return 'Google sign-in was cancelled.';
    }
    return 'Google sign-in failed: ${error.message ?? error.code}';
  }
}
