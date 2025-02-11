import 'package:ease_my_health/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TimeSlotGrid extends StatelessWidget {
  final List<String> slots;
  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;

  const TimeSlotGrid({
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = slot == selectedSlot;
        
        return GestureDetector(
          onTap: () => onSlotSelected(slot),
          child: SizedBox(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                
              ),
              child: Center(
                child: Text(
                  slot,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}