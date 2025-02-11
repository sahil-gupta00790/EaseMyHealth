import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:ease_my_health/core/themes/app_text_styles.dart';
import 'package:ease_my_health/shared/widgets/main_button.dart';
import 'package:ease_my_health/features/auth/presentation/screens/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Image.asset('assets/images/logo.png'),
              Image.asset('assets/images/text-logo.png'),
              const Spacer(flex: 2),
              Text(
                'Find the best Doctors around the world, at your fingertips.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteTextColor,
                  fontSize: AppTextStyles.medium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 30),
                child: MainButton(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  ),
                  text: 'Get Started',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}