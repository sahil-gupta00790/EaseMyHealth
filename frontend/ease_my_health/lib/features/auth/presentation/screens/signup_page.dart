import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:ease_my_health/core/themes/app_text_styles.dart';
import 'package:ease_my_health/features/auth/providers/auth_provider.dart';
import 'package:ease_my_health/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:ease_my_health/shared/widgets/main_button.dart';
import 'package:ease_my_health/features/home/presentation/screens/home_page.dart';
import 'package:ease_my_health/core/routing/custom_page_route.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New here? Welcome!",
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteTextColor,
                    fontSize: AppTextStyles.xxLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().slideX(
                      duration: 500.ms,
                      begin: -0.2,
                    ),
                      
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    "Please fill the form to continue.",
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
                  key: formKey.value,
                  child: Column(
                    children: [
                      AuthTextField(
                        controller: nameController,
                        hint: 'Full name',
                        keyboardType: TextInputType.name,
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 200.ms,
                          ),

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: emailController,
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
                            delay: 300.ms,
                          ),

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: phoneController,
                        hint: 'Phone number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "This field can't be empty";
                          }
                          if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value!)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 400.ms,
                          ),

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: passwordController,
                        hint: 'Password',
                        isPassword: true,
                        passwordVisible: isPasswordVisible.value,
                        onTogglePasswordVisibility: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 500.ms,
                          ),

                      const SizedBox(height: 70),

                      MainButton(
                        text: authState.isLoading ? 'Please wait...' : 'Sign Up',
                        onTap: () {
                          if (!authState.isLoading &&
                              (formKey.value.currentState?.validate() ?? false)) {
                            ref
                                .read(authProvider.notifier)
                                .signUp(
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  passwordController.text,
                                )
                                .then((_) {
                              if (authState.isAuthenticated) {
                                Navigator.push(
                                  context,
                                  BouncePageRoute(
                                    child: const HomeScreen(),
                                  ),
                                );
                              }
                            });
                          }
                        },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 600.ms,
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

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "or",
                              style: GoogleFonts.poppins(
                                color: AppColors.greyTextColor,
                                fontSize: AppTextStyles.medium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 550.ms),

                      const SizedBox(height: 16),

                      MainButton(
                        text: 'Sign Up with Google',
                        backgroundColor: AppColors.whiteTextColor,
                        textColor: AppColors.scaffoldBgColor,
                        iconPath: 'assets/images/google.png',
                        onTap: () => Navigator.push(
                          context,
                          BouncePageRoute(
                            child: const HomeScreen(),
                          ),
                        ),
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 600.ms,
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