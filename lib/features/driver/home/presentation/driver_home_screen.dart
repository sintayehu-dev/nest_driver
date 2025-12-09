import 'package:flutter/material.dart';
import 'widgets/location_header_card.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LocationHeaderCard(
              currentLocation: 'Your current location',
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Driver Home (mock screen)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

