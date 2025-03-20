import 'package:easemyhealth/common/widgets/appbar/appbar.dart';
import 'package:easemyhealth/common/widgets/images/app_circular_image.dart';
import 'package:easemyhealth/common/widgets/texts/section_heading.dart';
import 'package:easemyhealth/features/personalization/screens/settings/widgets/setting_tiles.dart';
import 'package:easemyhealth/utilities/constants/image_strings.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: Text('Profile'),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    AppCircularImage(
                      image: AppImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Divider(),
              SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              
              AppSectionHeading(
                title: 'Health Profile',
                showActionsButton: false,
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              AppSettingsMenuTile(
                  icon: Iconsax.profile_circle,
                  title: 'Personal Information',
                  subtitle: 'Manage your personal details',
                  onTap: () {}),

              AppSettingsMenuTile(
                  icon: Iconsax.clipboard_text,
                  title: 'Medical Records',
                  subtitle: 'View and manage your medical history',
                  onTap: () {}),

              AppSettingsMenuTile(
                  icon: Iconsax.hospital,
                  title: 'Medications',
                  subtitle: 'Track current medications ',
                  onTap: () {}),

              AppSettingsMenuTile(
                  icon: Iconsax.calendar,
                  title: 'Appointments',
                  subtitle: 'View past and upcoming appointments',
                  onTap: () {}),

              AppSettingsMenuTile(
                  icon: Iconsax.health,
                  title: 'Emergency Contacts',
                  subtitle: 'Add people to contact in emergency situations',
                  onTap: () {}),

              
              // -- App Settings
              SizedBox(height: AppSizes.spaceBtwSections),
              AppSectionHeading(
                title: 'App Settings',
                showActionsButton: false,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              AppSettingsMenuTile(
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  subtitle: 'Medication reminders and appointment alerts',
                  onTap: () {}),

              AppSettingsMenuTile(
                  icon: Iconsax.security,
                  title: 'Privacy & Security',
                  subtitle: 'Manage data usage and security settings',
                  onTap: () {}),

              AppSettingsMenuTile(
                icon: Iconsax.location,
                title: 'Location Services',
                subtitle: 'Find nearby healthcare facilities',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),

              AppSettingsMenuTile(
                icon: Iconsax.document_cloud,
                title: 'Data Backup',
                subtitle: 'Securely backup your medical data',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              AppSettingsMenuTile(
                  icon: Iconsax.colorfilter,
                  title: 'Accessibility',
                  subtitle: 'Configure who can watch your history',
                  onTap: () {}),

              SizedBox(height: AppSizes.spaceBtwSections),
              AppSettingsMenuTile(
                  icon: Iconsax.info_circle,
                  title: 'About & Help',
                  subtitle: 'App information and support resources',
                  onTap: () {}),

              SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Logout'),
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
