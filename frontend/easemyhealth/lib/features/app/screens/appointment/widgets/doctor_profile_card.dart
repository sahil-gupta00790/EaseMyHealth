import 'package:easemyhealth/common/widgets/doctor/speciality/specialities.dart';
import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class DoctorProfileCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;

  const DoctorProfileCard({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      color: AppColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                Specialities(text: specialty,backgroundColor: AppColors.primary,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}