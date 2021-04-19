import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/theme/style.dart';
import 'package:flutter_dicoding_fundamental/ui/article_web_view.dart';
import 'package:flutter_dicoding_fundamental/ui/detail_article.dart';
import 'package:flutter_dicoding_fundamental/ui/home_page.dart';
import 'package:flutter_dicoding_fundamental/ui/list_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(
            bodyColor: Colors.black,
          ),
          elevation: 0.0,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: secondaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        ),
      ),
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
  }
}