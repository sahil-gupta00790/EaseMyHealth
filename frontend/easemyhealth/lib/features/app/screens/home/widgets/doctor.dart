import 'package:easemyhealth/common/widgets/doctor/speciality/specialities.dart';
import 'package:easemyhealth/common/widgets/images/app_image_roundner.dart';
import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile image with decorated border
              AppImageRoundner(image: 'assets/images/yashraj.png',),
              
              SizedBox(height: 12),
              
              // Doctor name with improved typography
              Text(
                'Dr. Priyanshu',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              SizedBox(height: 4),
              
              // Specialty with subtle styling
              Specialities(text: 'Gym Trainer',backgroundColor: AppColors.cardColor!,),
            ],
          ),
        ),
      ),
    );
  }
}

