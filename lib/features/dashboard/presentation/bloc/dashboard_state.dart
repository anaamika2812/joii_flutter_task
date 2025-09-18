
import '../../../../domain/entities/user_entity.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final UserEntity user;
  DashboardLoaded(this.user);
}

class DashboardLoading extends DashboardState {}

class DashboardLoggedOut extends DashboardState {}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}