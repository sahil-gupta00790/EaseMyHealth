import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
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
      width: 300,
      margin: const EdgeInsets.all(8),
      child: Card(
        color: AppColors.textFieldBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Image with Emergency Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    hospital.imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (hospital.isEmergencyAvailable)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.emergency,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Emergency',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hospital.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteTextColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hospital.rating.toString(),
                            style: const TextStyle(
                              color: AppColors.whiteTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Hospital Type and Distance
                  Row(
                    children: [
                      Text(
                        hospital.type,
                        style: const TextStyle(
                          color: AppColors.available,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${hospital.distance.toStringAsFixed(1)} km away',
                        style: const TextStyle(
                          color: AppColors.greyTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Address
                  Text(
                    hospital.address,
                    style: const TextStyle(
                      color: AppColors.greyTextColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Facilities
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: hospital.facilities.map((facility) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.available.withAlpha((0.2*255).toInt()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        facility,
                        style: const TextStyle(
                          color: AppColors.available,
                          fontSize: 12,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}