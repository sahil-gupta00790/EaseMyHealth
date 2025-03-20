import 'package:easemyhealth/features/app/screens/home/widgets/hospital_card.dart';
import 'package:flutter/material.dart';

class HospitalsNearbySection extends StatelessWidget {
  const HospitalsNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Hospitals Nearby',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 185,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return HospitalCard();
            },
          ),
        ),
      ],
    );
  }
}
