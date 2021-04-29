import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/common/navigation.dart';
import 'package:flutter_dicoding_fundamental/common/style.dart';
import 'package:flutter_dicoding_fundamental/provider/preferences_provider.dart';
import 'package:flutter_dicoding_fundamental/ui/article_web_view.dart';
import 'package:flutter_dicoding_fundamental/ui/detail_article.dart';
import 'package:flutter_dicoding_fundamental/ui/home_page.dart';
import 'package:flutter_dicoding_fundamental/ui/list_page.dart';
import 'package:flutter_dicoding_fundamental/utils/background_service.dart';
import 'package:flutter_dicoding_fundamental/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'provider/news_provider.dart';
import 'provider/scheduling_provider.dart';
import 'utils/prefrences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => HomePage(),
              NewsListPage.routeName: (context) => NewsListPage(),
              ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                    article: ModalRoute.of(context).settings.arguments,
                  ),
              ArticleWebView.routeName: (context) => ArticleWebView(
                    article: ModalRoute.of(context).settings.arguments,
                  ),
            },
          );
        },
      ),
    );
  }
}
