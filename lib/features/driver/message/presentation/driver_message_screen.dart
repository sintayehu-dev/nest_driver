import 'package:flutter/material.dart';

class DriverMessageScreen extends StatelessWidget {
  const DriverMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: const Center(
        child: Text('Messages Screen'),
      ),
    );
  }
}

