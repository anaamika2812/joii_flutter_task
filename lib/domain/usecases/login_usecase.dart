import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Map<String, dynamic>> execute(String email, String password) {
    return repository.login(email, password);
  }
}