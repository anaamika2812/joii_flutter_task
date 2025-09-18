import 'package:dio/dio.dart';
import '../../../core/utils/constants.dart';

class AuthRemoteDataSource {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl$loginEndpoint',
        data: FormData.fromMap({'email': email, 'password': password}),
      );
      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}