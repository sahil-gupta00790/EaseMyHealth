import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/search_bar.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/appointment_section.dart';
import '../widgets/doctors_section.dart';
import '../widgets/hospital_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EaseMyHealth',style: TextStyle(color: AppColors.whiteTextColor),),
        backgroundColor: AppColors.primaryColor,
         iconTheme: const IconThemeData(color:AppColors.scaffoldBgColor),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSearchBar(),
            QuickActionsGrid(),
            UpcomingAppointmentsSection(),
            DoctorsNearbySection(),
            HospitalsNearbySection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: const TextStyle(color:AppColors.primaryColor),
        unselectedLabelStyle: const TextStyle(color: AppColors.primaryColor),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.scaffoldBgColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today,), label: 'Appointments',),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: 'Reminders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}