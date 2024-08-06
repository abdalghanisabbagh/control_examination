// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:control_examination/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add a listener to the document to handle right-clicks.
  html.document.onContextMenu.listen((event) {
    event.preventDefault(); // Prevent the default context menu
    // Custom action here
  });

  await Future.wait([
    Hive.initFlutter(),
    Hive.openBox('Token'),
    Hive.openBox('Profile'),
    Hive.openBox('ExamMission'),
  ]);

  runApp(MyApp());
}
