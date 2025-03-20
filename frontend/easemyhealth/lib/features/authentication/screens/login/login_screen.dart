import 'package:easemyhealth/common/styles/spacing_styles.dart';
import 'package:easemyhealth/common/widgets/login_signup/form_divider.dart';
import 'package:easemyhealth/common/widgets/login_signup/social_buttons.dart';
import 'package:easemyhealth/features/authentication/screens/login/widgets/login_form.dart';
import 'package:easemyhealth/features/authentication/screens/login/widgets/login_header.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: Column(
          children: [
            AppLoginHeader(),
            const SizedBox(height: AppSizes.spaceBtwItems),
            //Form
            AppLoginForm(),
            //divider
            AppFormDivider(dividerText: AppTexts.orSignInWith.capitalize!,),
            const SizedBox(height: AppSizes.spaceBtwSections,),
            //Footer
            AppSocialButton()
          ],
        ),
      ),
    ));
  }
}





