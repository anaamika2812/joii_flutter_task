import 'package:dio/dio.dart';

import '../../../core/utils/constants.dart';
import '../../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
        data: FormData.fromMap({'email': email, 'password': password}),
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}