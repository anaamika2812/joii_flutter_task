import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/shared_prefs_helper.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAuth>(_onCheckAuth);
    add(CheckAuth());
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));  // Splash delay
    final token = await SharedPrefsHelper.getToken();
    if (token != null) {
      emit(SplashAuthenticated());
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      emit(SplashUnauthenticated());
      Get.offAllNamed(AppRoutes.login);
    }
  }
}