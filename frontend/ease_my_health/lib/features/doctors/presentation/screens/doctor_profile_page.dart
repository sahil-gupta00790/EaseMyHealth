// doctor_profile_page.dart
import 'package:ease_my_health/features/appointments/presentation/screens/appointment_booking_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/main_button.dart';
import '../../../home/domain/model/doctor.dart';

class DoctorProfilePage extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfilePage({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: Column(
        children: [
          // Hero Image Section
          Hero(
            tag: 'doctor-${doctor.name}',
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(doctor.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.scaffoldBgColor.withAlpha((0.8*255).toInt()),
                        ],
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Doctor Information
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
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
                            fontSize: 24,
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
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toString(),
                            style: const TextStyle(
                              color: AppColors.whiteTextColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Specialization and Experience
                  Text(
                    doctor.specialization,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.available,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${doctor.experience} years of experience',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Availability Status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.textFieldBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: doctor.isAvailable
                                ? AppColors.available
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          doctor.isAvailable
                              ? 'Available Now'
                              : 'Next available at ${doctor.nextAvailableTime}',
                          style: TextStyle(
                            fontSize: 16,
                            color: doctor.isAvailable
                                ? AppColors.available
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Add more sections as needed (About, Services, Reviews, etc.)
                ],
              ),
            ),
          ),

          // Book Appointment Button
          Padding(
            padding: const EdgeInsets.all(16),
            child:  MainButton(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => AppointmentBookingScreen(doctorId: doctor.id,)),
                  ),
                  text: 'Book an Appointment',
                ),
          ),
        ],
      ),
    );
  }
}