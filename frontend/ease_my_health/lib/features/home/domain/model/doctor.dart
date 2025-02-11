import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
class Doctor with _$Doctor {
  const factory Doctor({
    required String id,
    required String name,
    required String specialization,
    required String imageUrl,
    required double rating,
    required int experience,
    required bool isAvailable,
    required String nextAvailableTime,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}