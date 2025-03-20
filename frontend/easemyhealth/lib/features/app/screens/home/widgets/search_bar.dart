import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:easemyhealth/utilities/constants/sizes.dart';
import 'package:easemyhealth/utilities/constants/text_strings.dart';
import 'package:easemyhealth/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=AppHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: TextField(
        style: TextStyle(
          color: dark?AppColors.white:AppColors.black,
        ),
        decoration: InputDecoration(
          hintText: AppTexts.searchBarHint,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: GestureDetector(
            onTap: () {},
            child: Icon(Icons.search, color: dark?AppColors.white:AppColors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}