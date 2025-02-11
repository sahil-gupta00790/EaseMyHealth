import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/home_repository.dart';
import 'home_state.dart';

part 'home_providers.g.dart';

@riverpod
class Home extends _$Home {
  late final HomeRepository _repository = HomeRepository();

  @override
  FutureOr<HomeState> build() async {
    return await fetchAllData();
  }

  Future<HomeState> fetchAllData() async {
    state = const AsyncLoading();
    try {
      final doctors = await _repository.fetchNearbyDoctors();
      final hospitals = await _repository.fetchNearbyHospitals();
      final appointments = await _repository.fetchUpcomingAppointments();

      return HomeState(
        nearbyDoctors: doctors,
        nearbyHospitals: hospitals,
        upcomingAppointments: appointments,
      );
    } catch (e) {
      return HomeState(errorMessage: e.toString());
    }
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = AsyncData(await fetchAllData());
  }
}

// Provider for the repository
@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}