// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      patientId: json['patientId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'dateTime': instance.dateTime.toIso8601String(),
      'status': instance.status,
    };
