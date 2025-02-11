import 'package:flutter/material.dart';
import 'quick_action_button.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        children: [
          QuickActionButton(
            title: 'Appointment Booking',
            icon: Icons.calendar_today,
            onTap: () => Navigator.pushNamed(context, '/appointment-booking'),
          ),
          QuickActionButton(
            title: 'Medical Reports',
            icon: Icons.medical_services,
            onTap: () => Navigator.pushNamed(context, '/medical-reports'),
          ),
          QuickActionButton(
            title: 'Medication',
            icon: Icons.medication,
            onTap: () => Navigator.pushNamed(context, '/medication'),
          ),
          QuickActionButton(
            title: 'Medical History',
            icon: Icons.history_edu,
            onTap: () => Navigator.pushNamed(context, '/medical-history'),
          ),
          QuickActionButton(
            title: 'Testing',
            icon: Icons.biotech,
            onTap: () => Navigator.pushNamed(context, '/testing'),
          ),
          QuickActionButton(
            title: 'Emergency',
            icon: Icons.emergency,
            onTap: () => Navigator.pushNamed(context, '/emergency'),
          ),
        ],
      ),
    );
  }
}