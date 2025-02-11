import 'package:flutter/material.dart';
import '../../domain/model/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(doctor.imageUrl),
            ),
            const SizedBox(height: 8),
            Text(doctor.name, style: const TextStyle(fontSize: 12)),
            Text(
              doctor.specialization,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
