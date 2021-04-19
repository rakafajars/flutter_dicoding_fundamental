import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/utils/received_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

/// Membuat inisialisasi karna akan dipanggil pada top level dari aplikasi
/// 2 variabel ini pun mengandung Stream yang dibuat agar aplikasi
/// dapat merespon dari notifikasi ketika inisiasi sudah
/// dilakukan pada fungsi main nantinya
final selectNotificationSubject = BehaviorSubject<String>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = '01';
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding_channel";
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  /// Request Permisions IOS Terbaru
  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// Request Permisions IOS model lama
  /// Membutuhkan callback yang dipicu saat notifikasi
  /// ditampilkan ketila aplikasi berada di foreground
  void configureDidReceiveLocalNotificationSubject(
      BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: receivedNotification.title != null
                  ? Text(receivedNotification.title)
                  : null,
              content: receivedNotification.body != null
                  ? Text(receivedNotification.body)
                  : null,
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.pushNamed(
                      context,
                      route,
                      arguments: receivedNotification,
                    );
                  },
                ),
              ],
            );
          });
    });
  }

  /// Macam - Macam Fungsi Notifikasi

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payLoad) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payLoad,
          ),
        );
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('Notificcation payload : ' + payload);
      }

      selectNotificationSubject.add(payload);
    });
  }
}

//
// Future<void> showNotification(
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//
//   /// Mengatur konfigurasi notifikasi pada platform android
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     _channelId,
//     _channelName,
//     _channelDesc,
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );
//
//   /// Mengatur konfigurasi notifikasi pada platform iOS
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//
//   /// Variable yang mengatur notifikasi untuk setiap platform yang telah dibuat
//   /// sebelumnya
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics,
//   );
//
//   /// Fungsi yang akan menampilkan notifikasi disetiap platformnya
//   /// property payload digunakan untuk meneruskan kembali
//   /// kepada aplikasi, ketika notifikasi di ketuk.
//   await flutterLocalNotificationsPlugin.show(
//       0,
//       'plain title',
//       'plain body',
//       platformChannelSpecifics,
//       payload: 'plain notification'
//   );
// }
