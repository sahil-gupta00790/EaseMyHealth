import 'package:easemyhealth/features/app/screens/home/home.dart';
import 'package:easemyhealth/features/app/screens/reminders/medication_reminder_screen.dart';
import 'package:easemyhealth/features/personalization/screens/settings/settings.dart';
import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NavigationController());
    final darkMode=AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height:80,
          elevation: 1,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value=index,
          backgroundColor: darkMode?AppColors.black:AppColors.white,
          indicatorColor: darkMode?AppColors.white.withAlpha(26):AppColors.black.withAlpha(26),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home_2), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.calendar_1), label: 'Appointments'),
            NavigationDestination(icon: Icon(Iconsax.notification_1), label: 'Reminders'),
            NavigationDestination(icon: Icon(Iconsax.profile_circle), label: 'Profile'),
          ],
        ),
      ),
      body:Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex=0.obs;

  final screens=[const HomePage(),Container(),MedicationsScreen(),ProfileScreen()];

}
