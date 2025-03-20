import 'package:easemyhealth/features/app/screens/home/widgets/doctor.dart';
import 'package:flutter/material.dart';

class DoctorsNearbySection extends StatelessWidget {
  const DoctorsNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Doctors Nearby',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF5F5F5),
            ),
          ),
        ),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return DoctorCard();
            },
          ),
        ),
      ],
    );
  }
}
