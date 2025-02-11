import 'package:ease_my_health/features/appointments/data/appointment_repository_impl.dart';
import 'package:ease_my_health/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_providers.g.dart';

@riverpod
class AppointmentNotifier extends _$AppointmentNotifier {
  @override
  FutureOr<List<String>> build(String doctorId, DateTime date) async {
    return await _fetchSlots(doctorId, date);
  }

  Future<List<String>> _fetchSlots(String doctorId, DateTime date) async {
    final repository = ref.read(appointmentRepositoryProvider);
    return await repository.getAvailableSlots(doctorId, date);
  }

  Future<void> bookAppointment(String doctorId, DateTime dateTime) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(appointmentRepositoryProvider);
      await repository.bookAppointment(doctorId, dateTime);
      state = AsyncData(await _fetchSlots(doctorId, dateTime));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

@riverpod
AppointmentRepositoryImpl appointmentRepository(Ref ref) {
  return AppointmentRepositoryImpl();
}