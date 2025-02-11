// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HospitalImpl _$$HospitalImplFromJson(Map<String, dynamic> json) =>
    _$HospitalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
      distance: (json['distance'] as num).toDouble(),
      isEmergencyAvailable: json['isEmergencyAvailable'] as bool,
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$HospitalImplToJson(_$HospitalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'distance': instance.distance,
      'isEmergencyAvailable': instance.isEmergencyAvailable,
      'address': instance.address,
      'rating': instance.rating,
      'facilities': instance.facilities,
    };
