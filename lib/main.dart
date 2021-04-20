import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/ui/home_page.dart';
import 'package:flutter_dicoding_fundamental/utils/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const title = 'Simple Alarm Manager';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     home: HomePage(
       title: title,
     ),
    );
  }
}



