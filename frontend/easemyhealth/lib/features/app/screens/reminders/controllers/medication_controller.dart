import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Controller for managing medication states
class MedicationController extends GetxController {
  // User meal times
  final Rx<TimeOfDay> breakfastTime = TimeOfDay(hour: 8, minute: 0).obs;
  final Rx<TimeOfDay> lunchTime = TimeOfDay(hour: 13, minute: 0).obs;
  final Rx<TimeOfDay> dinnerTime = TimeOfDay(hour: 19, minute: 0).obs;
  
  final RxMap<String, bool> medicationTakenStatus = <String, bool>{}.obs;
  final deviceStorage=GetStorage();
  
  void initMealTimes() {
    final storedBreakfastHour = deviceStorage.read<int>('breakfast_hour');
    
    if (storedBreakfastHour == null) {
      Future.delayed(Duration.zero, () => showMealTimeDialog());
    } else {
      // Load saved meal times
      breakfastTime.value = TimeOfDay(
        hour: deviceStorage.read<int>('breakfast_hour') ?? 8,
        minute: deviceStorage.read<int>('breakfast_minute') ?? 0,
      );
      
      lunchTime.value = TimeOfDay(
        hour: deviceStorage.read<int>('lunch_hour') ?? 13,
        minute: deviceStorage.read<int>('lunch_minute') ?? 0,
      );
      
      dinnerTime.value = TimeOfDay(
        hour: deviceStorage.read<int>('dinner_hour') ?? 19,
        minute: deviceStorage.read<int>('dinner_minute') ?? 0,
      );
    }
  }
  
  void showMealTimeDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Set Your Meal Times'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This helps us schedule your medication reminders accurately.'),
            SizedBox(height: 20),
            _buildTimePickerRow('Breakfast Time', breakfastTime),
            _buildTimePickerRow('Lunch Time', lunchTime),
            _buildTimePickerRow('Dinner Time', dinnerTime),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save meal times
              deviceStorage.write('breakfast_hour', breakfastTime.value.hour);
              deviceStorage.write('breakfast_minute', breakfastTime.value.minute);
              deviceStorage.write('lunch_hour', lunchTime.value.hour);
              deviceStorage.write('lunch_minute', lunchTime.value.minute);
              deviceStorage.write('dinner_hour', dinnerTime.value.hour);
              deviceStorage.write('dinner_minute', dinnerTime.value.minute);
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
  
  // Build time picker row for dialog
  Widget _buildTimePickerRow(String label, Rx<TimeOfDay> timeValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Obx(() => OutlinedButton(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: Get.context!,
                initialTime: timeValue.value,
              );
              if (picked != null) {
                timeValue.value = picked;
              }
            },
            child: Text(timeValue.value.format(Get.context!)),
          )),
        ],
      ),
    );
  }
  
  // Toggle medication taken status
  void toggleMedicationStatus(String medicationId) {
    if (medicationTakenStatus.containsKey(medicationId)) {
      medicationTakenStatus[medicationId] = !medicationTakenStatus[medicationId]!;
    } else {
      medicationTakenStatus[medicationId] = true;
    }
  }
  
  // Check if medication is taken
  bool isMedicationTaken(String medicationId) {
    return medicationTakenStatus[medicationId] ?? false;
  }
  
  // Calculate reminder time based on meal time and before/after setting
  TimeOfDay calculateReminderTime(String timingInstruction) {
    // Default offset in minutes
    final int beforeOffset = -30; // 30 minutes before meal
    final int afterOffset = 30; // 30 minutes after meal
    
    TimeOfDay baseTime;
    int offset;
    
    // Determine base time from meal
    if (timingInstruction.toLowerCase().contains('breakfast')) {
      baseTime = breakfastTime.value;
    } else if (timingInstruction.toLowerCase().contains('lunch')) {
      baseTime = lunchTime.value;
    } else {
      baseTime = dinnerTime.value; // Default to dinner
    }
    
    // Determine if before or after
    if (timingInstruction.toLowerCase().contains('before')) {
      offset = beforeOffset;
    } else {
      offset = afterOffset;
    }
    
    // Calculate new time
    int newMinutes = baseTime.minute + offset;
    int newHours = baseTime.hour;
    
    // Handle minute overflow or underflow
    if (newMinutes >= 60) {
      newHours += 1;
      newMinutes -= 60;
    } else if (newMinutes < 0) {
      newHours -= 1;
      newMinutes += 60;
    }
    
    // Handle hour overflow or underflow
    if (newHours >= 24) {
      newHours -= 24;
    } else if (newHours < 0) {
      newHours += 24;
    }
    
    return TimeOfDay(hour: newHours, minute: newMinutes);
  }
  
  // Check if medication is due now
  bool isMedicationDue(String timingInstruction) {
    final now = TimeOfDay.now();
    final reminderTime = calculateReminderTime(timingInstruction);
    
    // Convert to minutes since midnight for comparison
    final int nowMinutes = now.hour * 60 + now.minute;
    final int reminderMinutes = reminderTime.hour * 60 + reminderTime.minute;
    
    // Consider medication due if current time is within 60 minutes after reminder time
    return nowMinutes >= reminderMinutes && nowMinutes <= reminderMinutes + 60;
  }

  bool isMedicationTimeReached(String timingInstruction) {
  final now = TimeOfDay.now();
  final reminderTime = calculateReminderTime(timingInstruction);
  
  // Convert to minutes since midnight for comparison
  final int nowMinutes = now.hour * 60 + now.minute;
  final int reminderMinutes = reminderTime.hour * 60 + reminderTime.minute;
  
  // Check if current time is at or after the reminder time
  return nowMinutes >= reminderMinutes;
}
}