// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hospital.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Hospital _$HospitalFromJson(Map<String, dynamic> json) {
  return _Hospital.fromJson(json);
}

/// @nodoc
mixin _$Hospital {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  bool get isEmergencyAvailable => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  List<String> get facilities => throw _privateConstructorUsedError;

  /// Serializes this Hospital to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HospitalCopyWith<Hospital> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HospitalCopyWith<$Res> {
  factory $HospitalCopyWith(Hospital value, $Res Function(Hospital) then) =
      _$HospitalCopyWithImpl<$Res, Hospital>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String imageUrl,
      double distance,
      bool isEmergencyAvailable,
      String address,
      double rating,
      List<String> facilities});
}

/// @nodoc
class _$HospitalCopyWithImpl<$Res, $Val extends Hospital>
    implements $HospitalCopyWith<$Res> {
  _$HospitalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? imageUrl = null,
    Object? distance = null,
    Object? isEmergencyAvailable = null,
    Object? address = null,
    Object? rating = null,
    Object? facilities = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      isEmergencyAvailable: null == isEmergencyAvailable
          ? _value.isEmergencyAvailable
          : isEmergencyAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      facilities: null == facilities
          ? _value.facilities
          : facilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HospitalImplCopyWith<$Res>
    implements $HospitalCopyWith<$Res> {
  factory _$$HospitalImplCopyWith(
          _$HospitalImpl value, $Res Function(_$HospitalImpl) then) =
      __$$HospitalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String imageUrl,
      double distance,
      bool isEmergencyAvailable,
      String address,
      double rating,
      List<String> facilities});
}

/// @nodoc
class __$$HospitalImplCopyWithImpl<$Res>
    extends _$HospitalCopyWithImpl<$Res, _$HospitalImpl>
    implements _$$HospitalImplCopyWith<$Res> {
  __$$HospitalImplCopyWithImpl(
      _$HospitalImpl _value, $Res Function(_$HospitalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? imageUrl = null,
    Object? distance = null,
    Object? isEmergencyAvailable = null,
    Object? address = null,
    Object? rating = null,
    Object? facilities = null,
  }) {
    return _then(_$HospitalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      isEmergencyAvailable: null == isEmergencyAvailable
          ? _value.isEmergencyAvailable
          : isEmergencyAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      facilities: null == facilities
          ? _value._facilities
          : facilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HospitalImpl implements _Hospital {
  const _$HospitalImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.imageUrl,
      required this.distance,
      required this.isEmergencyAvailable,
      required this.address,
      required this.rating,
      required final List<String> facilities})
      : _facilities = facilities;

  factory _$HospitalImpl.fromJson(Map<String, dynamic> json) =>
      _$$HospitalImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String imageUrl;
  @override
  final double distance;
  @override
  final bool isEmergencyAvailable;
  @override
  final String address;
  @override
  final double rating;
  final List<String> _facilities;
  @override
  List<String> get facilities {
    if (_facilities is EqualUnmodifiableListView) return _facilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_facilities);
  }

  @override
  String toString() {
    return 'Hospital(id: $id, name: $name, type: $type, imageUrl: $imageUrl, distance: $distance, isEmergencyAvailable: $isEmergencyAvailable, address: $address, rating: $rating, facilities: $facilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HospitalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.isEmergencyAvailable, isEmergencyAvailable) ||
                other.isEmergencyAvailable == isEmergencyAvailable) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other._facilities, _facilities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      imageUrl,
      distance,
      isEmergencyAvailable,
      address,
      rating,
      const DeepCollectionEquality().hash(_facilities));

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HospitalImplCopyWith<_$HospitalImpl> get copyWith =>
      __$$HospitalImplCopyWithImpl<_$HospitalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HospitalImplToJson(
      this,
    );
  }
}

abstract class _Hospital implements Hospital {
  const factory _Hospital(
      {required final String id,
      required final String name,
      required final String type,
      required final String imageUrl,
      required final double distance,
      required final bool isEmergencyAvailable,
      required final String address,
      required final double rating,
      required final List<String> facilities}) = _$HospitalImpl;

  factory _Hospital.fromJson(Map<String, dynamic> json) =
      _$HospitalImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get imageUrl;
  @override
  double get distance;
  @override
  bool get isEmergencyAvailable;
  @override
  String get address;
  @override
  double get rating;
  @override
  List<String> get facilities;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HospitalImplCopyWith<_$HospitalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
