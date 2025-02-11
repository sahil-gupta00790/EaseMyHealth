import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.g.dart';
part 'appointment.freezed.dart';


@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String doctorName,
    required String specialization,
    required DateTime dateTime,
    required String status,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
}
