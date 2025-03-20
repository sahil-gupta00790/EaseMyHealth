import 'package:easemyhealth/features/app/screens/appointment/appointment_booking_screen.dart';
import 'package:easemyhealth/features/app/screens/home/widgets/action_button.dart';
import 'package:easemyhealth/features/app/screens/reminders/medication_reminder_screen.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace,
          vertical: AppSizes.defaultSpace / 2),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        children: [
          QuickActionButton(
            title: AppTexts.appointment,
            icon: Iconsax.calendar_add,
            onTap: () => Get.to(() => AppointmentBookingScreen(
                  doctorName: "Dr. Priyanshu Prajapati",
                  doctorSpecialty: "Gym trainer",
                  doctorImageUrl: "assets/images/image.png",
                ),),
          ),
          QuickActionButton(
            title: AppTexts.medicalReport,
            icon: Iconsax.document_upload,
            onTap: () {},
          ),
          QuickActionButton(
            title: AppTexts.medicationReminder,
            icon: Iconsax.timer_1,
            onTap: ()=>Get.to(()=>MedicationsScreen()),
          ),
          QuickActionButton(
            title: AppTexts.medicalHistory,
            icon: Iconsax.clipboard_text,
            onTap: () {},
          ),
          QuickActionButton(
            title: AppTexts.testing,
            icon: Iconsax.chart_square,
            onTap: () {},
          ),
          QuickActionButton(
            title: AppTexts.emergencyServices,
            icon: Iconsax.hospital,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
