import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> login(String email, String password);
  Future<UserEntity?> getUser();
  Future<void> logout();
}