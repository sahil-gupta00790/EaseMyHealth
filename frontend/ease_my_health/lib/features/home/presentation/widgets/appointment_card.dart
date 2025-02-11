import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/model/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xFF2196F3);

    // Calculate time difference
    final Duration timeUntilAppointment =
        appointment.dateTime.difference(DateTime.now());
    final bool isLessThanOneHour = timeUntilAppointment.inHours < 1 &&
        timeUntilAppointment.isNegative == false;
    final bool showJoinButton = isLessThanOneHour && appointment.isVirtual;

    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 8,
        color: AppColors.textFieldBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            //color: AppColors.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Status indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.available.withAlpha((0.2 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    color: AppColors.available,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Doctor name with icon
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.medical_services,
                      color: AppColors.available, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment.doctorName,
                      style: TextStyle(
                        color: AppColors.whiteTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Specialization
              Text(
                appointment.specialization,
                style: TextStyle(
                  color:
                      AppColors.whiteTextColor.withAlpha((0.7 * 255).toInt()),
                  fontSize: 14,
                ),
                textAlign: showJoinButton ? TextAlign.start : TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Date and time with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today, color: secondaryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}',
                    style: TextStyle(
                      color: AppColors.greyTextColor,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, color: secondaryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${appointment.dateTime.hour}:${appointment.dateTime.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: AppColors.greyTextColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              // Join button - only show if appointment is within 1 hour and is virtual
              if (showJoinButton) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.available,
                      foregroundColor: AppColors.whiteTextColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_call, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Join Consultation',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (!showJoinButton) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle appointment cancellation
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Use red for cancel
                      foregroundColor: AppColors.whiteTextColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
