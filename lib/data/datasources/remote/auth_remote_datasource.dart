import 'package:dio/dio.dart';

import '../../../core/utils/api_endpoints.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );
      return UserEntity.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}