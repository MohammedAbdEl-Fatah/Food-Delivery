import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/service/firebase_store_service.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';
import 'package:food_delivery/features/auth/log_in/data/model/user_google.dart';
import 'package:food_delivery/features/auth/log_in/domain/entities/log_in_entity.dart';
import 'package:food_delivery/features/auth/log_in/domain/repository/log_in_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/contents/enum.dart';
import '../../../../../core/storage/shared_preference.dart';

class FirebaseLogInRepository extends LogInRepository {
  final FirebaseStoreService _fireStoreService =
      FirebaseStoreService<UserEntity>(
        firestore: FirebaseFirestore.instance,
        collectionPath: 'users',
        fromMap: (map) => UserEntity.fromMap(map),
      );
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
    final user = await _googleSignIn.signIn();
    if (user != null) {
      final authentication = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      //save id in shared preferences
      await AppPreferences.instance.setString(
        key: SharedPreferenceKey.userId,
        value: userCredential.user!.uid,
      );
      log('####@#userCredential: ${userCredential.user!.uid}');
      log(
        '####@#userCredential: name:${userCredential.user?.displayName}, image:${user.photoUrl }, email:${userCredential.user?.email}',
      );
      UserGoogle userGoogle = UserGoogle(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
        photoUrl: userCredential.user!.providerData.first.photoURL ?? '',
        gender: '',
        birthday: '',
        createdAt: DateTime.now(),
        phone: userCredential.user!.phoneNumber ?? '',
        provider: 'google',
      );
      await _fireStoreService.add(userGoogle);
      return Right(userGoogle);
    } else {
      return Left(FirebaseFailure('Google sign-in was cancelled.'));
    }
  }
}
