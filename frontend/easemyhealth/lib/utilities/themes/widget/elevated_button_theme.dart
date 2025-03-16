import 'package:flutter/material.dart';

class AppElevatedButtonTheme{
  AppElevatedButtonTheme._();

static final light = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0XFFFF8000),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0XFFFF8000)),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ); 

  /// -- Dark Theme
  static final dark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0XFFFF8000),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0XFFFF8000)),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ); 
}