import 'package:dartz/dartz.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';

import '../../../../../core/utils/error/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterEntity>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required DateTime birthday,
    required String gender,
  });
}
