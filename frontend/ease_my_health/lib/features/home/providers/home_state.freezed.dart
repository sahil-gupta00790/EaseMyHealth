// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Doctor> get nearbyDoctors => throw _privateConstructorUsedError;
  List<Hospital> get nearbyHospitals => throw _privateConstructorUsedError;
  List<Appointment> get upcomingAppointments =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<Doctor> nearbyDoctors,
      List<Hospital> nearbyHospitals,
      List<Appointment> upcomingAppointments,
      String? errorMessage});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? nearbyDoctors = null,
    Object? nearbyHospitals = null,
    Object? upcomingAppointments = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      nearbyDoctors: null == nearbyDoctors
          ? _value.nearbyDoctors
          : nearbyDoctors // ignore: cast_nullable_to_non_nullable
              as List<Doctor>,
      nearbyHospitals: null == nearbyHospitals
          ? _value.nearbyHospitals
          : nearbyHospitals // ignore: cast_nullable_to_non_nullable
              as List<Hospital>,
      upcomingAppointments: null == upcomingAppointments
          ? _value.upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<Appointment>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Doctor> nearbyDoctors,
      List<Hospital> nearbyHospitals,
      List<Appointment> upcomingAppointments,
      String? errorMessage});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? nearbyDoctors = null,
    Object? nearbyHospitals = null,
    Object? upcomingAppointments = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$HomeStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      nearbyDoctors: null == nearbyDoctors
          ? _value._nearbyDoctors
          : nearbyDoctors // ignore: cast_nullable_to_non_nullable
              as List<Doctor>,
      nearbyHospitals: null == nearbyHospitals
          ? _value._nearbyHospitals
          : nearbyHospitals // ignore: cast_nullable_to_non_nullable
              as List<Hospital>,
      upcomingAppointments: null == upcomingAppointments
          ? _value._upcomingAppointments
          : upcomingAppointments // ignore: cast_nullable_to_non_nullable
              as List<Appointment>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.isLoading = false,
      final List<Doctor> nearbyDoctors = const [],
      final List<Hospital> nearbyHospitals = const [],
      final List<Appointment> upcomingAppointments = const [],
      this.errorMessage})
      : _nearbyDoctors = nearbyDoctors,
        _nearbyHospitals = nearbyHospitals,
        _upcomingAppointments = upcomingAppointments;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Doctor> _nearbyDoctors;
  @override
  @JsonKey()
  List<Doctor> get nearbyDoctors {
    if (_nearbyDoctors is EqualUnmodifiableListView) return _nearbyDoctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyDoctors);
  }

  final List<Hospital> _nearbyHospitals;
  @override
  @JsonKey()
  List<Hospital> get nearbyHospitals {
    if (_nearbyHospitals is EqualUnmodifiableListView) return _nearbyHospitals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbyHospitals);
  }

  final List<Appointment> _upcomingAppointments;
  @override
  @JsonKey()
  List<Appointment> get upcomingAppointments {
    if (_upcomingAppointments is EqualUnmodifiableListView)
      return _upcomingAppointments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingAppointments);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, nearbyDoctors: $nearbyDoctors, nearbyHospitals: $nearbyHospitals, upcomingAppointments: $upcomingAppointments, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._nearbyDoctors, _nearbyDoctors) &&
            const DeepCollectionEquality()
                .equals(other._nearbyHospitals, _nearbyHospitals) &&
            const DeepCollectionEquality()
                .equals(other._upcomingAppointments, _upcomingAppointments) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_nearbyDoctors),
      const DeepCollectionEquality().hash(_nearbyHospitals),
      const DeepCollectionEquality().hash(_upcomingAppointments),
      errorMessage);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final bool isLoading,
      final List<Doctor> nearbyDoctors,
      final List<Hospital> nearbyHospitals,
      final List<Appointment> upcomingAppointments,
      final String? errorMessage}) = _$HomeStateImpl;

  @override
  bool get isLoading;
  @override
  List<Doctor> get nearbyDoctors;
  @override
  List<Hospital> get nearbyHospitals;
  @override
  List<Appointment> get upcomingAppointments;
  @override
  String? get errorMessage;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
