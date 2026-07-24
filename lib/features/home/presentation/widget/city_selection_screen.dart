// lib/features/home/screens/city_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CitySelectionScreen extends StatefulWidget {
  const CitySelectionScreen({super.key});

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // قائمة مدن مصر + نيويورك عشان الديمو
  final List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Sharm El Sheikh',
    'Port Said',
    'Suez',
    'Mansoura',
    'Tanta',
    'New York City',
    'Los Angeles',
    'London',
    'Dubai',
    'Paris',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCities =
        cities
            .where(
              (city) => city.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: ColorManager.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select City',
          style: AppTextStyle.bodyLarge.copyWith(
            color: ColorManager.primary,
            fontWeight: FontWeight.bold,
            // backgroundColor: ColorManager.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search city...',
                hintStyle: const TextStyle(color: ColorManager.white),
                prefixIcon: const Icon(Icons.search, color: ColorManager.white),
                filled: true,
                fillColor: Colors.black.withAlpha(120),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
          ),

          // Cities List
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                return Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorManager.grey.withAlpha(50),
                  ),
                  child: ListTile(
                    style: ListTileStyle.list,
                    selectedColor: Colors.black,
                    selected: true,
                    leading: const Icon(
                      Icons.location_city,
                      color: ColorManager.primary,
                    ),
                    title: Text(
                      city,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black38,
                      size: 16,
                    ),
                    onTap: () {
                      // ارجع المدينة للـ parent
                      Navigator.pop(context, city);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
