import 'package:ease_my_health/features/appointments/domain/models/appointment.dart';

abstract class AppointmentRepository {
  Future<List<String>> getAvailableSlots(String doctorId, DateTime date);
  Future<void> bookAppointment(String doctorId, DateTime dateTime);
  Future<List<Appointment>> getUpcomingAppointments();
}