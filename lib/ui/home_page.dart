import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/custome_widget/platform_widget.dart';
import 'package:flutter_dicoding_fundamental/data/api/api_service.dart';
import 'package:flutter_dicoding_fundamental/provider/news_provider.dart';
import 'package:flutter_dicoding_fundamental/provider/scheduling_provider.dart';
import 'package:flutter_dicoding_fundamental/ui/detail_article.dart';
import 'package:flutter_dicoding_fundamental/ui/list_page.dart';
import 'package:flutter_dicoding_fundamental/ui/setting_page.dart';
import 'package:flutter_dicoding_fundamental/utils/background_service.dart';
import 'package:flutter_dicoding_fundamental/utils/notification_helper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  int _bottomNavIndex = 0;
  static const String _headlineText = 'Headline';

  List<Widget> _listWidget = [
    NewsListPage(),
    BookmarksPage(),
    SettingPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.news : Icons.public,
      ),
      title: Text(_headlineText),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.bookmark : Icons.bookmark,
      ),
      title: Text('Bookmarks'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
      ),
      title: Text(SettingPage.settingsTitle),
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    port.listen((_) async {
      await _service.someTask();
    });
    _notificationHelper
        .configureSelectNotificationSubject(ArticleDetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
