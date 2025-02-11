import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/model/doctor.dart';
import '../domain/model/hospital.dart';
import '../domain/model/appointment.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Doctor> nearbyDoctors,
    @Default([]) List<Hospital> nearbyHospitals,
    @Default([]) List<Appointment> upcomingAppointments,
    String? errorMessage,
  }) = _HomeState;
}