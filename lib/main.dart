import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/article_web_view.dart';
import 'package:flutter_dicoding_fundamental/detail_article.dart';
import 'package:flutter_dicoding_fundamental/m_article.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
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

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Apps'),
      ),
      /// Future -> Widget yang membangun widget berdasarkan interkasi terbaru
      /// dengan objek future
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString(
          'assets/articles.json',
        ),
        builder: (context, snapshot) {
          final List<Article> articles = parseArtciles(snapshot.data);
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, int index) {
              return _buildArticleItem(
                context,
                articles[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(
    BuildContext context,
    Article article,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: Image.network(
        article.urlToImage,
        width: 100,
      ),
      title: Text(article.title),
      subtitle: Text(
        article.author,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          ArticleDetailPage.routeName,
          arguments: article,
        );
      },
    );
  }
}
