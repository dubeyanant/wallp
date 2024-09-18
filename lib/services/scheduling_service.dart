import 'package:workmanager/workmanager.dart';

import 'wallpaper_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Call the function that changes the wallpaper
    generateAndSetWallpaper();
    return Future.value(true);
  });
}

void scheduleWallpaperChange(int intervalHours) {
  Workmanager().registerPeriodicTask(
    "uniqueWallpaperTask",
    "wallpaperChangeTask",
    frequency: Duration(hours: intervalHours),
  );
}

void initializeWorkManager() {
  // Set to false in production
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
}
