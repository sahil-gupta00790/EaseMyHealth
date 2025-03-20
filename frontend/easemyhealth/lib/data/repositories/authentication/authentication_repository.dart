import 'dart:async';

import 'package:easemyhealth/features/authentication/screens/login/login_screen.dart';
import 'package:easemyhealth/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController{
  
  static AuthenticationRepository get instance=>Get.find();

  final deviceStorage=GetStorage();

  @override
  void onReady(){
    Timer(const Duration(seconds: 3),(){});
    FlutterNativeSplash.remove();
    screenRedirect();
    
  }

  void screenRedirect(){
    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime')?Get.offAll(()=>const LoginScreen()):Get.offAll(()=>const OnboardingScreen());

  }
}