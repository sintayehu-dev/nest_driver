import 'package:flutter/material.dart';

class MainEntryPage extends StatelessWidget {
  const MainEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nest Driver'),
      ),
      body: const Center(
        child: Text('Welcome to Nest Driver'),
      ),
    );
  }
}


