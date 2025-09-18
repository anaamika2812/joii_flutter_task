import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

import '../../../../core/utils/shared_prefs_helper.dart';
import '../../../../data/datasources/remote/auth_remote_datasource.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc()
      : _loginUseCase = LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource(Dio()))),
        _logoutUseCase = LogoutUseCase(AuthRepositoryImpl(AuthRemoteDataSource(Dio()))),
        super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase.execute(event.email, event.password);
      await StorageHelper.saveToken('dummy_token'); // Replace with actual token if needed
      await StorageHelper.saveUserName(user.name);
      emit(AuthAuthenticated(userName: user.name));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _logoutUseCase.execute();
    await StorageHelper.clear();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final token = await StorageHelper.getToken();
    final userName = await StorageHelper.getUserName();
    if (token != null && userName != null) {
      emit(AuthAuthenticated(userName: userName));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}