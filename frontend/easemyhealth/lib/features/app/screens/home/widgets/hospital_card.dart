import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=AppHelperFunctions.isDarkMode(context);
    return Container(
      width: 160,
      margin: EdgeInsets.all(8),
      child: Card(
        clipBehavior: Clip.antiAlias, // Ensures image doesn't overflow rounded corners
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with gradient overlay
            Stack(
              children: [
                Image.asset(
                  'assets/images/hospital.png',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Subtle gradient overlay for better text visibility if needed
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black45,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Hospital info section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City Hospital',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 4),
                  
                  // Location info
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: dark?AppColors.white:AppColors.black,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Downtown Area',
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}