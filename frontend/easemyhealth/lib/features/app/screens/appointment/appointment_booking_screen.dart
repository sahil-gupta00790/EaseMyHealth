import 'package:easemyhealth/common/widgets/appbar/appbar.dart';
import 'package:easemyhealth/features/app/controllers/appointment_booking_controller.dart';
import 'package:easemyhealth/features/app/screens/appointment/widgets/date_selector.dart';
import 'package:easemyhealth/features/app/screens/appointment/widgets/doctor_profile_card.dart';
import 'package:easemyhealth/features/app/screens/appointment/widgets/time_slot_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;

  const AppointmentBookingScreen({
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(AppointmentBookingController(
      doctorName: doctorName,
      doctorSpecialty: doctorSpecialty,
      doctorImageUrl: doctorImageUrl,
    ));

    return Scaffold(
      appBar: AppAppBar(
        title: const Text('Book Appointment'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DoctorProfileCard(
              name: doctorName,
              specialty: doctorSpecialty,
              imageUrl: doctorImageUrl,
            ),
            const SizedBox(height: 20),
            Obx(
              () => DateSelector(
                selectedDate: controller.selectedDate.value,
                onDateSelected: controller.onDateSelected,
                customDates: controller.customDates,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.value != null) {
                return Text('Error: ${controller.errorMessage.value}');
              } else {
                return TimeSlotGrid(
                  slots: controller.timeSlots,
                  selectedSlot: controller.selectedTimeSlot.value,
                  onSlotSelected: controller.onSlotSelected,
                );
              }
            }),
            const Spacer(),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.selectedTimeSlot.value.isNotEmpty
                      ? controller.bookAppointment
                      : null,
                  child: const Text('Confirm Booking'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
