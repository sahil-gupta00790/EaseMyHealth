import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/constants/image_strings.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({
    super.key,
  });

  // Initialize Google Sign-In
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      
    );
    
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        // Get authentication details
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        
        // Here you have the tokens that you'll later send to your backend
        final String? idToken = googleAuth.idToken;
        final String? accessToken = googleAuth.accessToken;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed in as ${account.displayName}')),
        );
        
        // Print tokens to debug console (remove in production)
        print('ID Token: $idToken');
        print('Access Token: $accessToken');
        
        // TODO: Later you'll send these tokens to your backend
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $error')),
      );
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => _handleGoogleSignIn(context),
            icon: const Image(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              image: AssetImage(AppImages.google),
            ),
          ),
        ),
       
      ],
    );
  }
}