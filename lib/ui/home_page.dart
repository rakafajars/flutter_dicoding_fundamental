import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/utils/background_service.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async {
      await _service.someTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: Text('Alarm with Delayed (once)'),
              onPressed: () async {
                await AndroidAlarmManager.oneShot(
                  Duration(
                    seconds: 5,
                  ),
                  1,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Alarm with Date Time (once)'),
              onPressed: () async {
                await AndroidAlarmManager.oneShotAt(
                  DateTime.now().add(
                    Duration(
                      seconds: 5,
                    ),
                  ),
                  2,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Alarm with Periodic'),
              onPressed: () async {
                await AndroidAlarmManager.periodic(
                  Duration(
                    minutes: 1,
                  ),
                  3,
                  BackgroundService.callback,
                  startAt: DateTime.now(),
                  exact: true,
                  wakeup: true,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Cancel Alarm by Id'),
              onPressed: () async {
                await AndroidAlarmManager.cancel(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
