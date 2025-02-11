import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:ease_my_health/core/themes/app_text_styles.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final VoidCallback? onTogglePasswordVisibility;
  final bool passwordVisible;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.onTogglePasswordVisibility,
    this.passwordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? (value) {
        if (value?.isEmpty ?? true) {
          return "This field can't be empty";
        }
        return null;
      },
      obscureText: isPassword && !passwordVisible,
      style: GoogleFonts.poppins(
        color: AppColors.whiteTextColor,
      ),
      keyboardType: keyboardType,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        fillColor: AppColors.textFieldBgColor,
        filled: true,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textFieldHintColor,
          fontSize: AppTextStyles.medium,
          fontWeight: FontWeight.w400,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.greyTextColor,
                ),
                onPressed: onTogglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}