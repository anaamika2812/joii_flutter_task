import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/dashboard_content.dart';
import '../widgets/logout_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(LoadUser()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Joii Dashboard'),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardLoggedOut) {
              Get.offAllNamed(AppRoutes.login);
              Get.snackbar(
                'Logged Out',
                'You have been logged out successfully',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          },
          child: const Column(
            children: [
              Expanded(child: DashboardContent()),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}