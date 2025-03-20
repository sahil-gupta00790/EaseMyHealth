import 'package:easemyhealth/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final List<DateTime> customDates;
  
  const DateSelector({
    required this.selectedDate,
    required this.onDateSelected,
    required this.customDates,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the last available date (3 months from now)
    final lastAvailableDate = DateTime.now().add(const Duration(days: 90));
    
    // Generate the next 7 days
    final List<DateTime> nextSevenDays = List.generate(
      7, (index) => DateTime.now().add(Duration(days: index))
    );
    
    // Create list of displayed dates
    List<DateTime> displayDates = [...nextSevenDays, ...customDates];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => _showDatePicker(context, lastAvailableDate),
              child: const Text('View Calendar'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 82,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayDates.length, // +1 for the "More" button
            itemBuilder: (context, index) {
              // The last item is the "More" button
              if (index == displayDates.length) {
                return GestureDetector(
                  onTap: () => _showDatePicker(context, lastAvailableDate),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    
                  ),
                );
              }

              final date = displayDates[index];
              final isSelected = DateUtils.isSameDay(date, selectedDate);
              final isCustomDate = index >= 7; // Date is outside the 7-day window
              
              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: AnimatedContainer(
                  width: 80,
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCustomDate 
                        ? (isSelected ? AppColors.primary : Colors.orange.shade300)
                        : (isSelected ? AppColors.primary : Colors.grey.shade300),
                      width: isCustomDate ? 2 : 1,
                    ),
                    boxShadow: const [
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
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  void _showDatePicker(BuildContext context, DateTime lastAvailableDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: lastAvailableDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDate != null && pickedDate != selectedDate) {
      onDateSelected(pickedDate);
    }
  }
}