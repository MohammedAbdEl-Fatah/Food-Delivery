import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/features/home/presentation/widget/city_selection_screen.dart';
import 'package:food_delivery/features/home/presentation/widget/location_button.dart';
import '../../../../core/contents/enum.dart';
import '../../../../core/router/contents_router.dart';
import '../../../../core/storage/shared_preference.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String currentCity = 'Cairo';

  Widget notificationAppBar() {
    return IconButton(
      onPressed: () {
        //todo::navagate to notification screen
        Navigator.pushNamed(context, ContentsRouter.notificationScreen);
      },
      icon: const Icon(Icons.notifications, color: ColorManager.white, size: 32),
    );
  }

  @override
  void initState() {
    super.initState();
    currentCity = AppPreferences.instance.getString(
      key: SharedPreferenceKey.selectedCity,
      defaultValue: "Cairo",
    );
  }

  void _openCityPicker() async {
    final newCity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CitySelectionScreen()),
    );

    if (newCity != null && newCity is String) {
      setState(() => currentCity = newCity);
      await AppPreferences.instance.setString(
        key: SharedPreferenceKey.selectedCity,
        value: newCity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LocationButton(
          city: currentCity,
          onTap: () async {
            _openCityPicker();
          },
        ), //colum search
        //search
        const Spacer(),

        notificationAppBar(),
      ],
    );
  }
}
