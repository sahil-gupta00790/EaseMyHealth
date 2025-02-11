import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String doctorId,
    required String patientId,
    required DateTime dateTime,
    required String status,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => 
    _$AppointmentFromJson(json);
}