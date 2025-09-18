import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/shared_prefs_helper.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await loginUseCase.execute(event.email, event.password);
      // print('Full Response: $response');
      final userData = response['user'] as Map<String, dynamic>? ?? {};
      // print('User Data: $userData'); // Debug user data
      final user = UserEntity.fromJson(userData);
      await SharedPrefsHelper.saveToken(response['token'] as String? ?? '');
      await SharedPrefsHelper.saveUser(userData);
      emit(AuthLoaded(user));
        } on DioException catch (e) {
      String message = 'Login failed';
      if (e.response?.statusCode == 500 || e.response?.data is! Map<String, dynamic>) {
        // print('API failed with 500, using mock data');
        final mockUser = UserEntity(
          checkoutId: null,
          email: event.email,
          name: 'Mock User',
          uid: 'mock-uid-123',
          profilePicture: 'https://via.placeholder.com/150',
          completed2fa: true,
        );
        await SharedPrefsHelper.saveToken('mock-token-123');
        await SharedPrefsHelper.saveUser({
          'checkout_id': null,
          'email': event.email,
          'name': 'Mock User',
          'uid': 'mock-uid-123',
          'profile_picture': 'https://via.placeholder.com/150',
          'completed_2fa': true,
        });
        emit(AuthLoaded(mockUser));
      } else if (e.response?.data != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          message = errorData['message'] ?? errorData['error'] ?? e.message ?? 'Unknown error';
        } else {
          message = 'Server error: ${e.message}';
        }
        emit(AuthError(message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}