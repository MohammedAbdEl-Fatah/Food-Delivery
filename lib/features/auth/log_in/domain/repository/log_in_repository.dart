import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/log_in/data/model/user_google.dart';
import '../entities/log_in_entity.dart';

abstract class LogInRepository {
  Future<Either<Failure, LogInEntity>> logInEmail(
    String email,
    String password,
  );
  Future<Either<Failure, UserGoogle>> logInGoogle();
}
