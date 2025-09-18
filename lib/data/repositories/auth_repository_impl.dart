import 'package:dio/dio.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } on DioException {
      rethrow;
    }
  }
}