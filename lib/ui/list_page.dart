import 'package:flutter_dicoding_fundamental/custome_widget/card_article.dart';
import 'package:flutter_dicoding_fundamental/data/api/api_service.dart';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';

import 'detail_article.dart';
import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  static const routeName = '/article_list';

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  Future<ModelArticle> _futureArticle;

  @override
  void initState() {
    _futureArticle = ApiService().topHeadlines();
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _futureArticle,
      builder: (context, AsyncSnapshot<ModelArticle> snapshot) {
        /// Kondisi Koneksi
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.articles.length,
              itemBuilder: (context, int index) {
                var article = snapshot.data.articles[index];
                return CardArticle(
                  article: article,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ArticleDetailPage.routeName,
                      arguments: article,
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return Text('Apa ini');
          }
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {}

  Widget _buildIos(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Apps'),
      ),
      body: _buildList(context),
    );
  }
}
