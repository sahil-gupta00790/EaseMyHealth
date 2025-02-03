import 'package:ease_my_health/helpers/custom_page_route.dart';
import 'package:ease_my_health/helpers/theme_colors.dart';
import 'package:ease_my_health/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ease_my_health/components/main_button.dart';
import 'package:ease_my_health/helpers/font_size.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.scaffoldBgColor,
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
                    color: ThemeColors.whiteTextColor,
                    fontSize: FontSize.xxLarge,
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
                      // Name Field
                      _buildTextField(
                        controller: _nameController,
                        hint: "Full name",
                        keyboardType: TextInputType.name,
                        delay: 200,
                      ),

                      const SizedBox(height: 16),

                      // Email Field
                      _buildTextField(
                        controller: _emailController,
                        hint: "E-mail",
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
                        delay: 300,
                      ),

                      const SizedBox(height: 16),

                      // Phone Field
                      _buildTextField(
                        controller: _phoneController,
                        hint: "Phone number",
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
                        delay: 400,
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
                        decoration: _buildInputDecoration("Password").copyWith(
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
                            delay: 500.ms,
                          ),

                      const SizedBox(height: 70),

                      // Sign Up Button
                      MainButton(
                        text: _isLoading ? 'Please wait...' : 'Sign Up',
                        onTap: _isLoading
                            ? () {}
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() => _isLoading = true);
                                  final currentContext =
                                      context; // Store context before async gap

                                  await Future.delayed(
                                      const Duration(seconds: 2));

                                  setState(() => _isLoading = false);
                                  if (mounted) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(currentContext)
                                        .showSnackBar(
                                      // Use stored context
                                      SnackBar(
                                        content: Text(
                                          'Account created successfully!',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        backgroundColor:
                                            ThemeColors.primaryColor,
                                      ),
                                    );
                                    Navigator.pop(
                                        // ignore: use_build_context_synchronously
                                        currentContext); // Use stored context
                                  }
                                }
                              },
                      ).animate().slideX(
                            duration: 500.ms,
                            begin: -0.2,
                            delay: 600.ms,
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

                      // Google Login Button
                      MainButton(
                        text: 'Login with Google',
                        backgroundColor: ThemeColors.whiteTextColor,
                        textColor: ThemeColors.scaffoldBgColor,
                        iconPath: 'assets/images/google.png',
                        onTap: () => Navigator.push(
                                context,
                                BouncePageRoute(
                                  child:  HomePage(),
                                   // Slides from right to left
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    required int delay,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return "This field can't be empty";
            }
            return null;
          },
      style: GoogleFonts.poppins(
        color: ThemeColors.whiteTextColor,
      ),
      keyboardType: keyboardType,
      cursorColor: ThemeColors.primaryColor,
      decoration: _buildInputDecoration(hint),
    ).animate().slideX(
          duration: 500.ms,
          begin: -0.2,
          delay: delay.ms,
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
