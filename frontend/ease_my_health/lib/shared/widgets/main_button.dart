import 'package:ease_my_health/helpers/font_size.dart';
import 'package:ease_my_health/helpers/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final String? iconPath;
  final Function() onTap;
  const MainButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    required this.onTap,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? ThemeColors.primaryColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconPath == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image(
                        image: AssetImage(iconPath!),
                        height: 30,
                      ),
                    ),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: textColor ?? ThemeColors.whiteTextColor,
                  fontSize: FontSize.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}