import 'package:flutter/material.dart';

class AppChipTheme{
    AppChipTheme._();

    static ChipThemeData light=ChipThemeData(
        disabledColor: Colors.grey.withAlpha(102),
        labelStyle: const TextStyle(color:Colors.black),
        selectedColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
        checkmarkColor: Colors.white

    );
    static ChipThemeData dark=ChipThemeData(
        disabledColor: Colors.grey,
        labelStyle: const TextStyle(color:Colors.white),
        selectedColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
        checkmarkColor: Colors.white

    );
}