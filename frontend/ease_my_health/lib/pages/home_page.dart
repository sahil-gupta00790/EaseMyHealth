import 'package:ease_my_health/helpers/custom_page_route.dart';
import 'package:ease_my_health/pages/appointment_page.dart';
import 'package:ease_my_health/pages/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EaseMyHealth'),
        backgroundColor: Color(0xFF95E1B9),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style:TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Search doctors, medicines or hospitals',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        ZoomPageRoute(child:SearchPage()),
                      );
                    },
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Quick Action Grid
            _buildQuickActionGrid(context),

            // Upcoming Appointments
            _buildUpcomingAppointmentsSection(),

            // Doctors Nearby
            _buildDoctorsNearbySection(),

            // Hospitals Nearby
            _buildHospitalsNearbySection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildQuickActionGrid(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        children: [
          _gridButton(context, 'Appointment Booking', Icons.calendar_today, ()=>Navigator.push(
            context,
            ZoomPageRoute(child:AppointmentBookingPage()),
          )),
          _gridButton(context, 'Medical Reports Upload', Icons.medical_services, () {}),
          _gridButton(context, 'Medication Reminders', Icons.medication, () {}),
          _gridButton(context, 'Medical History', Icons.history_edu, () {}),
          _gridButton(context, 'Testing', Icons.biotech, () {}),
          _gridButton(context, 'Emergency Services', Icons.emergency, () {}),
        ],
      ),
    );
  }

  Widget _gridButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            SizedBox(height: 8),
            Text(title,
            textAlign: TextAlign.center,
             style:TextStyle(
              fontSize: 12,
              color: Colors.white,
              
              ),
              
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointmentsSection() {
  return SizedBox(
    height: 200,
    child: Column( // Use Column to add multiple children
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Change color if background is light
            ),
          ),
        ),
        Expanded( // Wrap ListView with Expanded to avoid overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: EdgeInsets.all(8),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. YashRaj Kumawat', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Cardiology Consultation'),
                        Text('Date: 15 Feb 2024, 10:00 AM'),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Join Consultation'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildDoctorsNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text('Doctors Nearby', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFFF5F5F5))),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: EdgeInsets.all(8),
                child: Card(
                  
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/image.png'),
                      ),
                      SizedBox(height: 8),
                      Text('Dr. Priyanshu', style: TextStyle(fontSize: 12)),
                      Text('Gym trainer', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHospitalsNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text('Hospitals Nearby', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFFF5F5F5))),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: EdgeInsets.all(8),
                child: Card(
                  child: Column(
                    children: [
                      Image.asset('assets/images/hospital.png',height:90,width:120,fit: BoxFit.cover),
                      SizedBox(height: 8),
                      Text('City Hospital', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
        BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Reminders'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}