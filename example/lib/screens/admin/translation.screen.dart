import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class AdminTranslationScreen extends StatelessWidget {
  const AdminTranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translation')),
      body: const Translation(
        languages: ['en', 'ko'],
      ),
    );
  }
}
