import 'dart:convert';

import 'package:flutter_dicoding_fundamental/common/navigation.dart';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );

    var initializationSettingIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload : ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ModelArticle modelArticle) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Headline News</b>";
    var titleNews = modelArticle.articles[0].title;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: json.encode(
        modelArticle.toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ModelArticle.fromJson(
          json.decode(
            payload,
          ),
        );

        var article = data.articles[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}
