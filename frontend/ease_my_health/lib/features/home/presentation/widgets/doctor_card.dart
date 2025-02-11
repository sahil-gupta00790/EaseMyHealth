import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../doctors/presentation/screens/doctor_profile_page.dart';
import '../../domain/model/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfilePage(doctor: doctor),
          ),
        );
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(8),
        child: Card(
          color: AppColors.textFieldBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Doctor Image with Hero
                Hero(
                  tag: 'doctor-${doctor.name}', // Unique tag for each doctor
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(doctor.imageUrl),
                  ),
                ),
            
              const SizedBox(width: 12),
              
              // Doctor Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            doctor.name,
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
                              doctor.rating.toString(),
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
                    
                    // Specialization
                    Text(
                      doctor.specialization,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Experience
                    Text(
                      '${doctor.experience} years of experience',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Availability Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: doctor.isAvailable
                            ? AppColors.available.withAlpha((0.2*255).toInt())
                            : Colors.red.withAlpha((0.2*255).toInt()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: doctor.isAvailable
                                  ? AppColors.available
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.isAvailable
                                ? 'Available Now'
                                : 'Next at ${doctor.nextAvailableTime}',
                            style: TextStyle(
                              fontSize: 12,
                              color: doctor.isAvailable
                                  ? AppColors.available
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}