import 'package:easemyhealth/common/widgets/login_signup/form_divider.dart';
import 'package:easemyhealth/common/widgets/login_signup/social_buttons.dart';
import 'package:easemyhealth/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:easemyhealth/features/authentication/screens/signup/widgets/terms_and_conditions.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/constants/text_strings.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              AppSignUpForm(),
              
              const SizedBox(height:AppSizes.spaceBtwSections,),
              const AppTermsAndConditions(),
              const SizedBox(height:AppSizes.spaceBtwSections,),
              //divider
              AppFormDivider(dividerText: AppTexts.orSignUpWith.capitalize!),
              const SizedBox(height:AppSizes.spaceBtwSections,),
              //footer
              const AppSocialButton()
            ],
          ),
        ),
      ),
    );
  }
}
