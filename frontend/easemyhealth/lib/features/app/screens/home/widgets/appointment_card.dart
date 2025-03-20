import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});


  @override
  Widget build(BuildContext context) {
    final dark=AppHelperFunctions.isDarkMode(context);
    return Container(
      width: 280,
      margin: EdgeInsets.all(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Header section with accent color
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.cardRadiusLg),
                  topRight: Radius.circular(AppSizes.cardRadiusLg),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. YashRaj Kumawat',
                    style: TextStyle(
                      color:dark?AppColors.white:AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.fontSizeLg,
                    ),
                  ),
                  SizedBox(height: AppSizes.xs),
                  Text(
                    'Cardiology Specialist',
                    style: TextStyle(
                      color: dark?AppColors.white:AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Appointment details with badge for status
            Container(
              padding: EdgeInsets.all(AppSizes.defaultSpace*1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date info
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: AppColors.darkGrey),
                          SizedBox(width: 8),
                          Text(
                            '15 Feb 2024',
                            style: Theme.of(context).textTheme.bodyMedium, 
                          ),
                        ],
                      ),
                      
                      // Time badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '10:00 AM',
                          style: Theme.of(context).textTheme.bodySmall!.apply(fontFamily: 'Poppins', color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Appointment type
                  Text(
                    'Appointment Type',
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: AppColors.darkGrey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Cardiology Consultation',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  
                  SizedBox(height: AppSizes.defaultSpace),
                  
                  // Status indicator
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Confirmed',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Join button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton.icon(
                onPressed: null,
                
                icon: Icon(Icons.video_call),
                label: Text('Join Consultation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor:AppColors.disabled,
                  foregroundColor: Colors.white,
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
  }
}