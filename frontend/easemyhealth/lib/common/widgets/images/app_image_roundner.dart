import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class AppImageRoundner extends StatelessWidget {
  const AppImageRoundner({
    super.key,
    required this.image,
    this.isNetworkImage = false,
    this.borderColor = AppColors.primary,
    this.radius = 40,
  });

  final double radius;
  final String image;
  final bool isNetworkImage;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor!,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage:
            isNetworkImage ? NetworkImage(image) : AssetImage(image),
      ),
    );
  }
}
