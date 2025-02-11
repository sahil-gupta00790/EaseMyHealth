import 'package:ease_my_health/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:ease_my_health/features/appointments/domain/models/appointment.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  List<String> _generateTimeSlots() {
    return [
      '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
      '14:00', '14:30', '15:00', '15:30', '16:00', '16:30',
    ];
  }

  @override
  Future<List<String>> getAvailableSlots(String doctorId, DateTime date) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _generateTimeSlots();
  }

  @override
  Future<void> bookAppointment(String doctorId, DateTime dateTime) async {
    await Future.delayed(Duration(seconds: 1));
    if (dateTime.hour < 9) throw Exception('Invalid time slot');
  }

  @override
  Future<List<Appointment>> getUpcomingAppointments() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Appointment(
        id: '1',
        doctorId: 'doc1',
        patientId: 'pat1',
        dateTime: DateTime.now().add(Duration(days: 1)),
        status: 'confirmed',
      ),
    ];
  }
}