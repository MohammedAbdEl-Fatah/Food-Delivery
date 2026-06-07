import 'package:flutter/material.dart';

import '../widget/item_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  /// !2 case -> read or not read
  /// *case of message -> discount and order and payment status

  //icon => pay | car order | discount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ItemNotification(
            title: 'Title',
            subtitle: 'Subtitle',
            time: '10:00',
          );
        },
      ),
    );
  }
}
