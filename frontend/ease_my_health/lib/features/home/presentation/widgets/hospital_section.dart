import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/home_providers.dart';
import 'hospital_card.dart';

class HospitalsNearbySection extends ConsumerWidget {
  const HospitalsNearbySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Hospitals Nearby',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF5F5F5),
            ),
          ),
        ),
        SizedBox(
          height: 234,
          child: homeState.when(
            data: (data) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.nearbyHospitals.length,
              itemBuilder: (context, index) => HospitalCard(
                hospital: data.nearbyHospitals[index],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text('Error: $error'),
            ),
          ),
        ),
      ],
    );
  }
}
