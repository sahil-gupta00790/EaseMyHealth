import 'package:easemyhealth/common/widgets/appbar/appbar.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/action_grid.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/appointments.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/doctor_nearby.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/hospital_nearby.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            HomeSearchBar(),

            // Quick Action Grid
            QuickActionGrid(),

            // Upcoming Appointments
            UpcomingAppointmentsSection(),

            // Doctors Nearby
            DoctorsNearbySection(),

            // Hospitals Nearby
            HospitalsNearbySection(),
          ],
        ),
      ),
    );
  }
}















