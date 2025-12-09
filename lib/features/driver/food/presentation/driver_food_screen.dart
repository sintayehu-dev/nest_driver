import 'package:flutter/material.dart';

class DriverFoodScreen extends StatelessWidget {
  const DriverFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          'Driver Food (placeholder)',
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}

