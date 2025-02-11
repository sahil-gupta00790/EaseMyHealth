import 'package:flutter/material.dart';
import '../../domain/model/hospital.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            Image.asset(
              hospital.imageUrl,
              height: 90,
              width: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              hospital.name,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}