// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String,
      doctorName: json['doctorName'] as String,
      specialization: json['specialization'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorName': instance.doctorName,
      'specialization': instance.specialization,
      'dateTime': instance.dateTime.toIso8601String(),
      'status': instance.status,
    };
