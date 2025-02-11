import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital.freezed.dart';
part 'hospital.g.dart';

@freezed
class Hospital with _$Hospital {
  const factory Hospital({
    required String id,
    required String name,
    required String type,
    required String imageUrl,
    required double distance,
    required bool isEmergencyAvailable,
    required String address,
    required double rating,
    required List<String> facilities,
  }) = _Hospital;

  factory Hospital.fromJson(Map<String, dynamic> json) => _$HospitalFromJson(json);
}