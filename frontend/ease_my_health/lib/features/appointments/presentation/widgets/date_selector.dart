import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:56,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 7,
    itemBuilder: (context, index) {
      final date = DateTime.now().add(Duration(days: index));
      final isSelected = date.day == selectedDate.day;
      
      return GestureDetector(
        onTap: () => onDateSelected(date),
        child: AnimatedContainer(
          width: 80, 
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), // Adjust padding
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(date),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              Text(
                date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
);
  }
}