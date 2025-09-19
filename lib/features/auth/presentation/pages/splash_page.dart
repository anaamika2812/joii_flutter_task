import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.find<AuthBloc>().add(CheckAuthEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Get.find<AuthBloc>(), // Provide the bloc instance
      builder: (context, state) {
        if (state is AuthLoading) {
          return Scaffold(
            backgroundColor: AppColors.primaryOrange,
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is AuthAuthenticated) {
          Future.microtask(() => Get.offNamed('/dashboard'));
          return Scaffold(
            backgroundColor: AppColors.primaryOrange,
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (state is AuthUnauthenticated) {
          Future.microtask(() => Get.offNamed('/login'));
          return Scaffold(
            backgroundColor: AppColors.primaryOrange,
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.primaryOrange,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.primaryOrange,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.face,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: 20),
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}