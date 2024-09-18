import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/scheduling_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeWorkManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
