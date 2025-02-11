import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search doctors, medicines or hospitals',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/search'),
            child: const Icon(Icons.search, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
