import 'package:easemyhealth/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:easemyhealth/features/authentication/screens/signup/signup_screen.dart';
import 'package:easemyhealth/navigation_menu.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class AppLoginForm extends StatelessWidget {
  const AppLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.sms),
                labelText: AppTexts.email,
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: AppTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields / 2,
            ),
            //remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(AppTexts.rememberMe),
                  ],
                ),
                TextButton(
                    onPressed: ()=>Get.to(()=>const ForgotPasswordScreen()),
                    child: const Text(AppTexts.forgetPassword))
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            //Signin Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: ()=>Get.to(()=>NavigationMenu()),
                    child: const Text(AppTexts.signIn))),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: ()=>Get.to(()=>SignUpScreen()),
                    child: const Text(AppTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}