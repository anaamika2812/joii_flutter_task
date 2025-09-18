import 'package:get/get.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: dashboard, page: () => const DashboardPage()),
  ];
}