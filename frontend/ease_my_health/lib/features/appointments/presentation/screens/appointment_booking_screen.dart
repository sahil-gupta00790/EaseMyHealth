import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:ease_my_health/features/appointments/presentation/widgets/date_selector.dart';
import 'package:ease_my_health/features/appointments/presentation/widgets/doctor_profile_card.dart';
import 'package:ease_my_health/features/appointments/presentation/widgets/time_slot_grid.dart';
import 'package:ease_my_health/features/appointments/providers/appointment_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentBookingScreen extends ConsumerStatefulWidget {
  final String doctorId;
  
  const AppointmentBookingScreen({required this.doctorId, super.key});

  @override
  ConsumerState<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends ConsumerState<AppointmentBookingScreen> {
  late DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    final slotsAsync = ref.watch(
      appointmentNotifierProvider(widget.doctorId, selectedDate)
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const DoctorProfileCard(name:"Something",specialty:"Something",imageUrl:"assets/images/image.png"),
            const SizedBox(height: 20),
            DateSelector(
              selectedDate: selectedDate,
              onDateSelected: (date) => setState(() => selectedDate = date),
            ),
            const SizedBox(height: 20),
            slotsAsync.when(
              data: (slots) => TimeSlotGrid(
                slots: slots,
                selectedSlot: selectedTimeSlot,
                onSlotSelected: (slot) => setState(() => selectedTimeSlot = slot),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: $error'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTimeSlot != null
                    ? () => _bookAppointment()
                    : null,
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _bookAppointment() async {
    if (selectedTimeSlot == null) return;
    
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(selectedTimeSlot!.split(':')[0]),
      int.parse(selectedTimeSlot!.split(':')[1]),
    );

    try {
      await ref.read(appointmentNotifierProvider(widget.doctorId, selectedDate).notifier)
          .bookAppointment(widget.doctorId, dateTime);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book appointment: $e')),
        );
      }
    }
  }
}