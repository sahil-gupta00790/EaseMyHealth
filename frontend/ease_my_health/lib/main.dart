import 'package:flutter/material.dart';
import 'package:ease_my_health/helpers/theme_colors.dart';
import 'package:ease_my_health/pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Picco',
      theme: ThemeData(
        primaryColor: ThemeColors.primaryColor,
        scaffoldBackgroundColor: ThemeColors.scaffoldBgColor,
      ),
      home: WelcomePage(),
    );
  }
}