import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppointmentBookingController extends GetxController {
  // Doctor information
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  
  // Observable variables
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedTimeSlot = RxString('');
  final RxList<String> timeSlots = <String>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<String?> errorMessage = Rx<String?>(null);
  
  // Custom dates list (moved from DateSelector)
  final RxList<DateTime> customDates = <DateTime>[].obs;
  
  AppointmentBookingController({
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
  });
  
  @override
  void onInit() {
    super.onInit();
    fetchTimeSlots();
  }
  
  void onDateSelected(DateTime date) {
    // If date is different, clear the selected time slot
    if (!DateUtils.isSameDay(selectedDate.value, date)) {
      selectedTimeSlot.value = ''; // Reset selected slot
    }
    
    // Check if the selected date is a custom date and manage the list
    _checkAndAddCustomDate(date);
    
    // Update selected date
    selectedDate.value = date;
    fetchTimeSlots();
  }
  
  void _checkAndAddCustomDate(DateTime date) {
    // Get the next 7 days
    final List<DateTime> nextSevenDays = List.generate(
      7, (index) => DateTime.now().add(Duration(days: index))
    );
    
    // Check if the date is outside the 7-day window
    bool isCustomDate = !nextSevenDays.any(
      (d) => DateUtils.isSameDay(d, date)
    );
    
    // If it's a custom date, add it to our list
    if (isCustomDate) {
      // Remove the date if it already exists in our custom dates list
      customDates.removeWhere((d) => DateUtils.isSameDay(d, date));
      
      // Add the new custom date
      if (customDates.length < 3) {
        // If we have less than 3 custom dates, just add it
        customDates.add(date);
      } else {
        // If we already have 3 custom dates, remove the oldest one
        customDates.removeAt(0);
        customDates.add(date);
      }
    }
  }
  
  void onSlotSelected(String slot) {
    // Only allow one slot at a time
    if (selectedTimeSlot.value == slot) {
      // If the same slot is tapped again, deselect it
      selectedTimeSlot.value = '';
    } else {
      // Select the new slot
      selectedTimeSlot.value = slot;
    }
  }
  
  Future<void> fetchTimeSlots() async {
    isLoading.value = true;
    errorMessage.value = null;
    selectedTimeSlot.value = ''; // Reset selection when fetching new slots
    
    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in a real app, this would be different based on the date
      final dayOfWeek = selectedDate.value.weekday;
      
      // Generate different slots based on the day of the week
      if (dayOfWeek == DateTime.saturday || dayOfWeek == DateTime.sunday) {
        // Weekend slots
        timeSlots.value = [
          '10:00 AM', '10:30 AM', '11:00 AM', 
          '11:30 AM', '12:00 PM', '12:30 PM',
        ];
      } else {
        // Weekday slots
        timeSlots.value = [
          '9:00 AM', '9:30 AM', '10:00 AM', 
          '10:30 AM', '11:00 AM', '11:30 AM',
          '2:00 PM', '2:30 PM', '3:00 PM',
        ];
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> bookAppointment() async {
    if (selectedTimeSlot.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a time slot',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return;
    }
    
    isLoading.value = true;
    errorMessage.value = null;
    
    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful booking
      final appointmentData = {
        'doctorName': doctorName,
        'doctorSpecialty': doctorSpecialty,
        'date': selectedDate.value,
        'timeSlot': selectedTimeSlot.value,
      };
      
      // Here you would typically send this data to your backend
      print('Appointment booked: $appointmentData');
      
      // Show success message and navigate back
      Get.snackbar(
        'Success',
        'Appointment booked successfully!',
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
      );
      
      // Navigate back after successful booking
      Get.back(result: appointmentData);
      
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to book appointment: ${e.toString()}',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}