import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/m_article.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custome_widget/custome_scaffold.dart';

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';
  final Article article;

  const ArticleWebView({@required this.article});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        initialUrl: article.url,
      ),
    );
  }
}
