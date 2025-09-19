
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Exception, UserEntity>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      await localDataSource.saveUser(user);
      return Right(user);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<UserEntity?> getUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }
}