import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/custome_widget/custom_button.dart';
import 'package:flutter_dicoding_fundamental/theme/style.dart';
import 'package:flutter_dicoding_fundamental/ui/article_web_view.dart';
import 'package:flutter_dicoding_fundamental/ui/detail_article.dart';
import 'package:flutter_dicoding_fundamental/ui/home_page.dart';
import 'package:flutter_dicoding_fundamental/ui/list_page.dart';
import 'package:flutter_dicoding_fundamental/utils/notification_helper.dart';
import 'package:flutter_dicoding_fundamental/utils/received_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  _notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(
    MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  static const routeName = "/";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();

    /// Pemanggilan Fungsi notifikasi pada initState
    /// bertujuan untuk fungsi yang hanya berjalan hanya 1 kali saja
    _notificationHelper.configureSelectNotificationSubject(
      context,
      DetailPage.routeName,
    );
    _notificationHelper.configureDidReceiveLocalNotificationSubject(
      context,
      DetailPage.routeName,
    );
  }

  @override
  void dispose() {
    /// memanggil variable lalu menyimpan di dispose
    /// digunakan untuk agar tidak terjadinya kebocoran
    /// pada stream
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Notification'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CustomButton(
                  text: 'Show plain notification with payload',
                  onPressed: () async {
                    await _notificationHelper
                        .showNotification(flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Show plain notification that has no body with payload',
                  onPressed: () async {
                    await _notificationHelper.showNotificationWithNoBody(
                        flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Show schedule notification with payload',
                  onPressed: () async {
                    await _notificationHelper
                        .scheduleNotification(flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Show grouped notifications [Android]',
                  onPressed: () async {
                    await _notificationHelper.showGroupedNotifications(
                        flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text:
                      'Show progress notification - updates every second [Android]',
                  onPressed: () async {
                    await _notificationHelper.showProgressNotification(
                        flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Show big picture notification [Android]',
                  onPressed: () async {
                    await _notificationHelper.showBigPictureNotification(
                        flutterLocalNotificationsPlugin);
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Show notification with attachment [iOS]',
                  onPressed: () async {
                    await _notificationHelper.showNotificationWithAttachment(
                        flutterLocalNotificationsPlugin);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  @override
  Widget build(BuildContext context) {
    final ReceivedNotification arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Title : ${arg.payload}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back!'),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         primaryColor: primaryColor,
//         accentColor: secondaryColor,
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: myTextTheme,
//         appBarTheme: AppBarTheme(
//           textTheme: myTextTheme.apply(
//             bodyColor: Colors.black,
//           ),
//           elevation: 0.0,
//         ),
//         buttonTheme: ButtonThemeData(
//           buttonColor: secondaryColor,
//           textTheme: ButtonTextTheme.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(0),
//             ),
//           ),
//         ),
//       ),
//       initialRoute: HomePage.routeName,
//       routes: {
//         HomePage.routeName: (context) => HomePage(),
//         NewsListPage.routeName: (context) => NewsListPage(),
//         ArticleDetailPage.routeName: (context) => ArticleDetailPage(
//               article: ModalRoute.of(context).settings.arguments,
//             ),
//         ArticleWebView.routeName: (context) => ArticleWebView(
//               article: ModalRoute.of(context).settings.arguments,
//             ),
//       },
//     );
//   }
// }
