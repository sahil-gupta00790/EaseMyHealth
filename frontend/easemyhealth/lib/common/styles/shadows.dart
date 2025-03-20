import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class AppShadowStyle {

  static final verticalProductShadow = BoxShadow(
    color: AppColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  ); // BoxShadow

  static final horizontalProductShadow = BoxShadow(
    color: AppColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  ); // BoxShadow
}

