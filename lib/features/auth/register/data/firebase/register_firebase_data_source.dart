import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';

class FirebaseRegisterDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, RegisterEntity>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required DateTime birthday,
    required String gender,
    required int age,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) {
        return Left(FirebaseFailure("Registration failed: no user returned"));
      }

      await user.updateDisplayName(name);
      await user.reload();

      await _firestore.collection('users').doc(user.uid).set({
        'userID': user.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'birthday': birthday.toIso8601String(),
        'gender': gender,
        'age': age,
        'createdAt': FieldValue.serverTimestamp(),
        'confrimEmail': false,
      });
      return Right(
        RegisterEntity(
          id: user.uid,
          name: name,
          email: email,
          phone: phone,
          birthday: birthday,
          gender: gender,
          age: age,
          confrimEmail: false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      final msg = _mapFirebaseAuthCodeToMessage(e.code, e.message);
      return Left(FirebaseFailure(msg));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}

String _mapFirebaseAuthCodeToMessage(String code, String? fallback) {
  switch (code) {
    case 'email-already-in-use':
      return 'This email is already in use.';
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'weak-password':
      return 'Password is too weak.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled.';
    case 'network-request-failed':
      return 'Network error. Please check your connection.';
    default:
      return fallback ?? 'Registration failed.';
  }
}
