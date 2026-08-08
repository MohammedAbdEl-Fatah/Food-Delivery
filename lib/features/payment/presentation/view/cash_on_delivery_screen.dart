import 'package:flutter/material.dart';

class CashOnDeliveryScreen extends StatelessWidget {
  const CashOnDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash on Delivery'),
      ),
      body: const Center(
        child: Text('This is the Cash on Delivery Screen'),
      ),
    );
  }
}