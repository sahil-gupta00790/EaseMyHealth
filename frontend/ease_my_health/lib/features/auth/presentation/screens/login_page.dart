import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ease_my_health/core/themes/app_text_styles.dart';
import 'package:ease_my_health/features/auth/providers/auth_provider.dart';
import 'package:ease_my_health/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:ease_my_health/shared/widgets/main_button.dart';
import 'package:ease_my_health/features/auth/presentation/screens/signup_page.dart';
import 'package:ease_my_health/core/routing/custom_page_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isPasswordVisible = useState(false);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get you in!",
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteTextColor,
                    fontSize: AppTextStyles.xxLarge,
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
                      color: AppColors.greyTextColor,
                      fontSize: AppTextStyles.medium,
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
                      AuthTextField(
                        controller: _emailController,
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
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
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 200.ms,
                          ),

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _passwordController,
                        hint: 'Password',
                        isPassword: true,
                        passwordVisible: isPasswordVisible.value,
                        onTogglePasswordVisibility: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 300.ms,
                          ),

                      const SizedBox(height: 70),

                      MainButton(
                        text: authState.isLoading ? 'Please wait...' : 'Login',
                        onTap: () {
                          if (!authState.isLoading &&
                              (_formKey.currentState?.validate() ?? false)) {
                            ref
                                .read(authProvider.notifier)
                                .signIn(
                                  _emailController.text,
                                  _passwordController.text,
                                )
                                .then((_) {
                              if (authState.isAuthenticated) {
                                // Navigate to home page
                              }
                            });
                          }
                        },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 500.ms,
                          ),

                      if (authState.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            authState.errorMessage!,
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: AppTextStyles.medium,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Google Login Button
                      MainButton(
                        text: 'Login with Google',
                        backgroundColor: AppColors.whiteTextColor,
                        textColor: AppColors.scaffoldBgColor,
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
                                color: AppColors.whiteTextColor,
                                fontSize: AppTextStyles.medium,
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
                                  color: AppColors.primaryColor,
                                  fontSize: AppTextStyles.medium,
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
}
