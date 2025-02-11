import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/model/doctor.dart';
import '../domain/model/hospital.dart';
import '../domain/model/appointment.dart';
import 'home_state.dart';
part 'home_providers.g.dart';

@riverpod
class Home extends _$Home {
  @override
  FutureOr<HomeState> build() async {
    return await fetchAllData(); // Automatically fetch data on provider initialization
  }

  Future<HomeState> fetchAllData() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      return HomeState(
        nearbyDoctors: [
          Doctor(id: '1', name: 'Dr. Priyanshu', specialization: 'Gym trainer', imageUrl: 'assets/images/image.png'),
        ],
        nearbyHospitals: [
          Hospital(id: '1', name: 'City Hospital', imageUrl: 'assets/images/hospital.png'),
        ],
        upcomingAppointments: [
          Appointment(id: '1', doctorName: 'Dr. YashRaj Kumawat', specialization: 'Cardiology Consultation', dateTime: DateTime(2024, 2, 15, 10, 0), status: 'Scheduled'),
        ],
      );
    } catch (e, st) {
      throw AsyncError(e, st);
    }
  }
}
