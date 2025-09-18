import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/shared_prefs_helper.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    userName = await StorageHelper.getUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'Welcome, ${userName ?? 'User'}',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            key: const Key('logout_button'),
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              Fluttertoast.showToast(msg: 'Logged out successfully');
              Get.offNamed(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 40,
                            color: Colors.blue[300],
                            title: '40%',
                            titleStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          ),
                          PieChartSectionData(
                            value: 30,
                            color: Colors.green[300],
                            title: '30%',
                            titleStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.red[300],
                            title: '20%',
                            titleStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          ),
                          PieChartSectionData(
                            value: 10,
                            color: Colors.yellow[300],
                            title: '10%',
                            titleStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          ),

                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        borderData: FlBorderData(show: false),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 800),
                      swapAnimationCurve: Curves.easeInOut,
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.details);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'View Details',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}