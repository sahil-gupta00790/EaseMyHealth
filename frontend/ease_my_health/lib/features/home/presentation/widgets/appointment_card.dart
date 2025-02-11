import 'package:flutter/material.dart';
import '../../domain/model/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.doctorName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(appointment.specialization),
              Text(
                'Date: ${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}, '
                '${appointment.dateTime.hour}:${appointment.dateTime.minute.toString().padLeft(2, '0')}',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Join Consultation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}