import 'package:easemyhealth/features/app/screens/reminders/controllers/medication_controller.dart';
import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MedicationReminderCard extends StatelessWidget {
  final String id; // Unique identifier for the medication
  final String medicationName;
  final String dosage;
  final String frequency;
  final String timingInstruction; // Before/After breakfast/lunch/dinner
  final bool isActive;

  // Get controller instance
  final MedicationController controller = Get.find<MedicationController>();

  MedicationReminderCard({
    super.key,
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.timingInstruction,
    this.isActive = true,
  });

  // Get icon based on timing instruction
  IconData _getTimingIcon() {
    if (timingInstruction.contains('Before')) {
      return Icons.hourglass_top;
    } else if (timingInstruction.contains('After')) {
      return Icons.hourglass_bottom;
    }
    return Icons.access_time;
  }

  // Get color based on timing
  Color _getTimingColor() {
    final Map<String, Color> mealColors = {
      'breakfast': Colors.orange.shade300,
      'lunch': Colors.amber.shade600,
      'dinner': Colors.indigo.shade300,
    };

    for (final meal in mealColors.keys) {
      if (timingInstruction.toLowerCase().contains(meal)) {
        return mealColors[meal]!;
      }
    }

    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final timingColor = _getTimingColor();

    return Obx(() {
      final bool taken = controller.isMedicationTaken(id);
      final bool isDue = controller.isMedicationDue(timingInstruction);
      final reminderTime = controller.calculateReminderTime(timingInstruction);

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(12),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Header with medication name
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.defaultSpace),
                decoration: BoxDecoration(
                  color: isActive
                      ? dark
                          ? AppColors.cardColor
                          : timingColor
                      : AppColors.darkGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.cardRadiusLg),
                    topRight: Radius.circular(AppSizes.cardRadiusLg),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicationName,
                          style: TextStyle(
                            color: dark ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.fontSizeLg,
                          ),
                        ),
                        SizedBox(height: AppSizes.xs),
                        Text(
                          dosage,
                          style: TextStyle(
                            color: dark ? AppColors.white : AppColors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: taken
                            ? AppColors.success
                            : timingColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: taken ? AppColors.success : timingColor,
                          width: 2,
                        ),
                      ),
                      child: taken
                          ? Icon(Icons.check,
                              color: AppColors.success, size: 28)
                          : Icon(Icons.medication,
                              color: timingColor, size: 28),
                    ),
                  ],
                ),
              ),

              // Medication details
              Container(
                padding: EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  children: [
                    // Time and timing instruction row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Time info
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 16, color: AppColors.darkGrey),
                            SizedBox(width: 8),
                            Text(
                              reminderTime.format(context),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),

                        // Timing instruction badge
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isActive
                                ? timingColor.withOpacity(0.2)
                                : AppColors.darkGrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isActive ? timingColor : AppColors.darkGrey,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_getTimingIcon(),
                                  size: 14,
                                  color: isActive
                                      ? timingColor
                                      : AppColors.darkGrey),
                              SizedBox(width: 4),
                              Text(
                                timingInstruction,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(
                                      color: isActive
                                          ? timingColor
                                          : AppColors.darkGrey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Frequency
                    Row(
                      children: [
                        Icon(Icons.repeat, size: 16, color: AppColors.darkGrey),
                        SizedBox(width: 8),
                        Text(
                          frequency,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.defaultSpace),

                    // Status indicator
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: taken
                                ? AppColors.success
                                : (isDue ? Colors.amber : AppColors.darkGrey),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          taken ? 'Taken' : (isDue ? 'Due Now' : 'Upcoming'),
                          style: TextStyle(
                            color: taken
                                ? AppColors.success
                                : (isDue ? Colors.amber : AppColors.darkGrey),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ElevatedButton.icon(
                  onPressed: (isActive &&
                          controller.isMedicationTimeReached(timingInstruction))
                      ? () {
                          controller.toggleMedicationStatus(id);
                        }
                      : null,
                  icon: Icon(
                      taken ? Icons.restart_alt : Icons.check_circle_outline),
                  label: Text(taken ? 'Mark as Not Taken' : 'Mark as Taken'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        taken ? Colors.grey.shade200 : AppColors.primary,
                    foregroundColor: taken ? AppColors.darkGrey : Colors.white,
                    disabledBackgroundColor: AppColors.disabled,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
