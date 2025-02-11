// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorImpl _$$DoctorImplFromJson(Map<String, dynamic> json) => _$DoctorImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      experience: (json['experience'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
      nextAvailableTime: json['nextAvailableTime'] as String,
    );

Map<String, dynamic> _$$DoctorImplToJson(_$DoctorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialization': instance.specialization,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'experience': instance.experience,
      'isAvailable': instance.isAvailable,
      'nextAvailableTime': instance.nextAvailableTime,
    };
