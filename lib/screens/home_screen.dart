import 'package:flutter/material.dart';

import 'package:wallp/services/wallpaper_service.dart';
import 'package:wallp/services/scheduling_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallp')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async => await generateAndSetWallpaper(),
              child: const Text('Change Wallpaper Now'),
            ),
            ElevatedButton(
              onPressed: () => scheduleWallpaperChange(12),
              child: const Text('Change Every 12 Hours'),
            ),
            ElevatedButton(
              onPressed: () => scheduleWallpaperChange(24),
              child: const Text('Change Every 24 Hours'),
            ),
          ],
        ),
      ),
    );
  }
}
