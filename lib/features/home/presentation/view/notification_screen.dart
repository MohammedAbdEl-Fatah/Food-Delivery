import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  /// !2 case -> read or not read
  /// *case of message -> discount and order and payment status

  //icon => pay | car order | discount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const ItemNotification(),
    );
  }
}

class ItemNotification extends StatelessWidget {
  const ItemNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ColorManager.white,
      child: ListTile(
        title: Text("Header"),
        subtitle: Text("Subtitle"),
        leading: Card(
          color: ColorManager.lightGrey,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notification_add),
          ),
        ),
      ),
    );
  }
}
