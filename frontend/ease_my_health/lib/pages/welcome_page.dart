import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ease_my_health/components/main_button.dart';
import 'package:ease_my_health/helpers/font_size.dart';
import 'package:ease_my_health/helpers/theme_colors.dart';
import 'package:ease_my_health/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/Chizuru.jpg'),
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  ThemeColors.scaffoldBgColor,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'EasyMyhealth',
                      style: GoogleFonts.poppins(
                        color: ThemeColors.titleColor,
                        fontSize: FontSize.xxxLarge,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Find the best Doctors around the world,at your fingertips.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: ThemeColors.whiteTextColor,
                      fontSize: FontSize.medium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: MainButton(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        result: false,
                      ),
                      text: 'Get Started',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}