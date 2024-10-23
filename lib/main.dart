import 'package:control_examination/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path); 


  await Future.wait([
    Hive.openBox('Token'),
    Hive.openBox('Profile'),
    Hive.openBox('ExamMission'),
  ]);

  runApp(MyApp());
}
