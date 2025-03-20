// First, set up your MedicationsScreen
import 'package:easemyhealth/common/widgets/appbar/appbar.dart';
import 'package:easemyhealth/features/app/screens/reminders/controllers/medication_controller.dart';
import 'package:easemyhealth/features/app/screens/reminders/widgets/medication_reminder_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicationsScreen extends StatelessWidget {
  final MedicationController medicationController = Get.put(MedicationController());

  MedicationsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Initialize the controller when the screen loads
    medicationController.initMealTimes();
    
    return Scaffold(
      appBar: AppAppBar(
        title: Text('My Medications'),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () => medicationController.showMealTimeDialog(),
            tooltip: 'Update Meal Times',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MedicationReminderCard(
              id: 'med1',
              medicationName: 'Metformin',
              dosage: '500mg - 1 tablet',
              frequency: 'Daily',
              timingInstruction: 'Before Breakfast',
            ),
            
            MedicationReminderCard(
              id: 'med2',
              medicationName: 'Lisinopril',
              dosage: '10mg - 1 tablet',
              frequency: 'Twice daily',
              timingInstruction: 'After Lunch',
            ),
            
            MedicationReminderCard(
              id: 'med3',
              medicationName: 'Atorvastatin',
              dosage: '20mg - 1 tablet',
              frequency: 'Daily',
              timingInstruction: 'Before Dinner',
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new medication reminder
          // You would typically navigate to an "Add Medication" screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}