import 'package:flutter/material.dart';
enum SearchCategory {
    doctors,
    hospitals,
    medicines
  }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _searchText = '';
  SearchCategory _selectedCategory = SearchCategory.doctors;

  // Enum to represent search categories
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          // Custom navigation row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton(
                  category: SearchCategory.doctors, 
                  label: 'Doctor'
                ),
                SizedBox(width: 8),
                _buildCategoryButton(
                  category: SearchCategory.hospitals, 
                  label: 'Hospital'
                ),
                SizedBox(width: 8),
                _buildCategoryButton(
                  category: SearchCategory.medicines, 
                  label: 'Medicine'
                ),
              ],
            ),
          ),
          
          // Content based on selected category
          Expanded(
            child: _buildCategoryContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({
    required SearchCategory category, 
    required String label
  }) {
    bool isSelected = _selectedCategory == category;
    
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black, backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
      ),
      child: Text(label),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategory) {
      case SearchCategory.doctors:
        return _searchDoctors().isEmpty
            ? Center(child: Text('No doctors found'))
            : _buildSearchResults('Doctors', _searchDoctors());
      case SearchCategory.hospitals:
        return _searchClinics().isEmpty
            ? Center(child: Text('No hospitals found'))
            : _buildSearchResults('Hospitals', _searchClinics());
      case SearchCategory.medicines:
        return _searchMedicines().isEmpty
            ? Center(child: Text('No medicines found'))
            : _buildSearchResults('Medicines', _searchMedicines());
    }
  }

  Widget _buildSearchResults(String title, List<Widget> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: results.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) => results[index],
        ),
      ],
    );
  }

  List<Widget> _searchDoctors() {
    return [
      _buildDoctorCard(
        'Dr. Priyanshu Prajapati',
        'assets/images/image.png',
        4.5,
        ['Cardiology', 'Internal Medicine'],
      ),
      _buildDoctorCard(
        'Dr. Yashraj Kumawat',
        'assets/images/yashraj.png',
        4.8,
        ['Pediatrics', 'Family Medicine'],
      ),
    ];
  }

  Widget _buildDoctorCard(
    String name,
    String imageUrl,
    double rating,
    List<String> specialties,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage:AssetImage(imageUrl) as ImageProvider,
              radius: 32,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  _buildRatingStars(rating),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: specialties.map((specialty) => _buildSpecialtyChip(specialty)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  Widget _buildSpecialtyChip(String specialty) {
    return Chip(
      label: Text(specialty),
      backgroundColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  List<Widget> _searchClinics() {
    return [
      _buildClinicCard(
        'City Hospital',
        'assets/images/hospital.png',
        ['Cardiology', 'Orthopedics', 'Pediatrics'],
      ),
      _buildClinicCard(
        'Family Medical Center',
        'assets/images/clinic.png',
        ['Family Medicine', 'Internal Medicine', 'Pediatrics'],
      ),
      // Add more clinic cards as needed
    ];
  }

  Widget _buildClinicCard(String name, String imageUrl, List<String> specialties) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: specialties.map((specialty) => _buildSpecialtyChip(specialty)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _searchMedicines() {
    return [
      _buildMedicineCard(
        'Aspirin',
        'assets/images/aspirin.png',
        'Pain relief, fever reduction',
      ),
      _buildMedicineCard(
        'Metformin',
        'assets/images/metformin.png',
        'Diabetes management',
      ),
      // Add more medicine cards as needed
    ];
  }

  Widget _buildMedicineCard(String name, String imageUrl, String description) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 64,
              height: 64,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}