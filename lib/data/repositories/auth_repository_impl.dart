
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    return await _remoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    // No API call needed for logout, just clear local storage
  }
}