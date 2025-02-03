import 'package:ease_my_health/helpers/custom_page_route.dart';
import 'package:ease_my_health/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ease_my_health/components/main_button.dart';
import 'package:ease_my_health/helpers/font_size.dart';
import 'package:ease_my_health/helpers/theme_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Text(
                  "Let's get you in!",
                  style: GoogleFonts.poppins(
                    color: ThemeColors.whiteTextColor,
                    fontSize: FontSize.xxLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().slideX(
                      duration: 500.ms,
                      begin: -0.2,
                      curve: Curves.easeOutQuad,
                    ),

                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    "Login to your account.",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.greyTextColor,
                      fontSize: FontSize.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate().slideX(
                      duration: 500.ms,
                      begin: -0.2,
                      delay: 100.ms,
                    ),

                const SizedBox(height: 70),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "This field can't be empty";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(
                          color: ThemeColors.whiteTextColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: ThemeColors.primaryColor,
                        decoration: _buildInputDecoration('Email'),
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 200.ms,
                          ),

                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                        style: GoogleFonts.poppins(
                          color: ThemeColors.whiteTextColor,
                        ),
                        cursorColor: ThemeColors.primaryColor,
                        decoration: _buildInputDecoration('Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ThemeColors.greyTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 300.ms,
                          ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: ThemeColors.greyTextColor,
                              fontSize: FontSize.medium,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: 400.ms),

                      const SizedBox(height: 70),

                      // Login Button
                      MainButton(
                        text: _isLoading ? 'Please wait...' : 'Login',
                        onTap: _isLoading
                            ? () {}
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() => _isLoading = true);
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  setState(() => _isLoading = false);
                                  if (mounted) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Login Successful!',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        backgroundColor:
                                            ThemeColors.primaryColor,
                                      ),
                                    );
                                  }
                                }
                              },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 500.ms,
                          ),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: ThemeColors.greyTextColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "or",
                              style: GoogleFonts.poppins(
                                color: ThemeColors.greyTextColor,
                                fontSize: FontSize.medium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: ThemeColors.greyTextColor,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 550.ms),
                      const SizedBox(height: 16),
                      // Google Login Button
                      MainButton(
                        text: 'Login with Google',
                        backgroundColor: ThemeColors.whiteTextColor,
                        textColor: ThemeColors.scaffoldBgColor,
                        iconPath: 'assets/images/google.png',
                        onTap: () {},
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 600.ms,
                          ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.poppins(
                                color: ThemeColors.whiteTextColor,
                                fontSize: FontSize.medium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                SlideUpFadePageRoute(
                                  child: const SignUpPage(),
                                   // Slides from right to left
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.poppins(
                                  color: ThemeColors.primaryColor,
                                  fontSize: FontSize.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      fillColor: ThemeColors.textFieldBgColor,
      filled: true,
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        color: ThemeColors.textFieldHintColor,
        fontSize: FontSize.medium,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }
}
