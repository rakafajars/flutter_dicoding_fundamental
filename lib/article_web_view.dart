import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/m_article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';
  final Article article;

  const ArticleWebView({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: WebView(
        initialUrl: article.url,
      ),
    );
  }
}
