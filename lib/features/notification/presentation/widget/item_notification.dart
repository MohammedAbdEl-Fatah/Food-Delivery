import 'package:flutter/material.dart';

import '../../../../core/Colors/color_manager.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });
  final String title;
  final String subtitle;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ColorManager.white,
      child: ListTile(
        title: Text(title), //title of notification
        subtitle: Text(subtitle), //body of subtitle
        leading: const Card(
          color: ColorManager.lightGrey,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notification_add), //stutes icon
          ),
        ),
        trailing: Text(time),

        ///value time
      ),
    );
  }
}
