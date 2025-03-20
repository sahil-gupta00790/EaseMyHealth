import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.xs),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            SizedBox(height: AppSizes.defaultSpace),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
            ),
          ],
        ),
      ),
    );
  }
}