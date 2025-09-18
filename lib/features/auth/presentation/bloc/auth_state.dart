
import '../../../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UserEntity user;
  AuthLoaded(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}