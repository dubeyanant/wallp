import 'dart:ui' as ui;
import 'dart:io';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

Future<ui.Image> createWallpaper(String text) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = Colors.black;

  // Fill the canvas with a black background
  canvas.drawRect(const Rect.fromLTWH(0, 0, 1080, 1920), paint);

  // Determine the font size based on text length
  double fontSize = calculateFontSize(text);

  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(color: Colors.white, fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(minWidth: 0, maxWidth: 1080);

  // Center the text
  final xCenter = (1080 - textPainter.width) / 2;
  final yCenter = (1920 - textPainter.height) / 2;
  textPainter.paint(canvas, Offset(xCenter, yCenter));

  final picture = recorder.endRecording();
  return await picture.toImage(1080, 1920);
}

Future<void> generateAndSetWallpaper() async {
  // List of text to randomly choose from
  List<String> textList = [
    "The greatest glory in living lies not in never falling, but in rising every time we fall.",
    "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma - which is living with the results of other people's thinking.",
    "My favorite quotes contain messages that provide wisdom. I can carry these messages with me daily and find inspiration to be the best version of myself. You'll notice below I've gathered bits of knowledge from activists, leaders, and authors.",
    "Well done is better than well said."
  ];

  String selectedText = textList[Random().nextInt(textList.length)];

  // Create wallpaper image
  ui.Image wallpaper = await createWallpaper(selectedText);

  // Save the image as a file
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/wallpaper.png';

  final byteData = await wallpaper.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();
  File(path).writeAsBytesSync(buffer);

  // Set the wallpaper using flutter_wallpaper_manager
  int location =
      WallpaperManager.HOME_SCREEN; // Use HOME_SCREEN, LOCK_SCREEN or BOTH
  bool result = await WallpaperManager.setWallpaperFromFile(path, location);

  developer.log(
    result ? "Wallpaper applied successfully!" : "Failed to set wallpaper.",
  );
}

double calculateFontSize(String text) {
  if (text.length < 20) {
    return 100.0; // Large font for short text
  } else if (text.length < 50) {
    return 50.0; // Medium font for medium text
  } else {
    return 30.0; // Smaller font for longer text
  }
}
