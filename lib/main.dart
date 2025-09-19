import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local/auth_local_datasource.dart';
import 'data/datasources/remote/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/dashboard_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();
  final remoteDataSource = AuthRemoteDataSourceImpl(dio);
  final localDataSource = AuthLocalDataSourceImpl(prefs);
  final repository = AuthRepositoryImpl(remoteDataSource, localDataSource);
  final loginUseCase = LoginUseCase(repository);
  final getUserUseCase = GetUserUseCase(repository);
  final logoutUseCase = LogoutUseCase(repository);

  // Register AuthBloc with GetX
  Get.put(
    AuthBloc(
      loginUseCase: loginUseCase,
      getUserUseCase: getUserUseCase,
      logoutUseCase: logoutUseCase,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
debugShowCheckedModeBanner: false,
      title: 'Joii App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/dashboard', page: () => const DashboardPage()),
      ],
    );
  }
}
