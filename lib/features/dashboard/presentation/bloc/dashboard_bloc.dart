import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/shared_prefs_helper.dart';
import '../../../../domain/entities/user_entity.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadUser>(_onLoadUser);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<DashboardState> emit) async {
    try {
      final userData = await SharedPrefsHelper.getUser();
      if (userData != null) {
        final user = UserEntity.fromJson({'user': userData, 'token': ''});  // Token not needed here
        emit(DashboardLoaded(user));
      } else {
        emit(DashboardError('No user data found'));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<DashboardState> emit) async {
    await SharedPrefsHelper.clearAuth();
    emit(DashboardLoggedOut());
  }
}