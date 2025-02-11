import '../../domain/model/doctor.dart';
import '../../domain/model/hospital.dart';
import '../../domain/model/appointment.dart';

class HomeRepository {
  Future<List<Doctor>> fetchNearbyDoctors() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      Doctor(
        id: '1',
        name: 'Dr. Priyanshu',
        specialization: 'Gym trainer',
        imageUrl: 'assets/images/image.png',
        rating: 4.5,
        experience: 5,
        isAvailable: true,
        nextAvailableTime: '10:00 AM',
      ),
      Doctor(
        id: '2',
        name: 'Dr. YashRaj Kumawat',
        specialization: 'Cardiologist',
        imageUrl: 'assets/images/yashraj.png',
        rating: 4.5,
        experience: 5,
        isAvailable: false,
        nextAvailableTime: '12:00 PM',
      ),
    ];
  }

  Future<List<Hospital>> fetchNearbyHospitals() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Hospital(
        id:"1",
        name: "City General Hospital",
        type: "General Hospital",
        imageUrl: "assets/images/hospital.png",
        distance: 2.5,
        isEmergencyAvailable: true,
        address: "123 Healthcare Street, Medical District",
        rating: 4.5,
        facilities: ["ICU", "Emergency", "Pharmacy", "Lab"],
      ),
    ];
  }

  Future<List<Appointment>> fetchUpcomingAppointments() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Appointment(
        id: '1',
        doctorName: 'Dr. YashRaj Kumawat',
        specialization: 'Cardiology Consultation',
        dateTime: DateTime(2025, 2, 15, 10, 0),
        status: 'Scheduled',
        isVirtual: true,
      ),
      Appointment(
        id: '2',
        doctorName: 'Dr. Priyanshu',
        specialization: 'Gym trainer',
        dateTime: DateTime(2025, 2, 11, 20, 30),
        status: 'Scheduled',
        isVirtual: true,
      )
    ];
  }
}
