import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/themes/widget/appbar_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/bottom_sheet_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/checkbox_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/chip_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/elevated_button_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/outlined_button_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/text_field_theme.dart';
import 'package:easemyhealth/utilities/themes/widget/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightTheme=ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: Color(0XFFFF8000),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.light,
    chipTheme: AppChipTheme.light,
    appBarTheme: AppAppBarTheme.light,
    checkboxTheme: AppCheckBoxTheme.light,
    bottomSheetTheme: AppBottomSheetTheme.light,
    elevatedButtonTheme: AppElevatedButtonTheme.light,
    outlinedButtonTheme: AppOutlinedButtonTheme.light,
    inputDecorationTheme: AppTextFieldTheme.light,
    );
  static ThemeData darkTheme=ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    disabledColor: AppColors.grey,
    primaryColor: Color(0XFFFF8000),
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.dark,
    chipTheme: AppChipTheme.dark,
    appBarTheme: AppAppBarTheme.dark,
    checkboxTheme: AppCheckBoxTheme.dark,
    bottomSheetTheme: AppBottomSheetTheme.dark,
    elevatedButtonTheme: AppElevatedButtonTheme.dark,
    outlinedButtonTheme: AppOutlinedButtonTheme.dark,
    inputDecorationTheme: AppTextFieldTheme.dark,
  );
}