import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class Specialities extends StatelessWidget {
  const Specialities({
    super.key,
    required this.text,
    required this.backgroundColor ,
  });
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
