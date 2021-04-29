import 'package:flutter/cupertino.dart';
import 'package:flutter_dicoding_fundamental/custome_widget/card_article.dart';
import 'package:flutter_dicoding_fundamental/custome_widget/platform_widget.dart';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';
import 'package:flutter_dicoding_fundamental/provider/news_provider.dart';
import 'package:provider/provider.dart';

import 'detail_article.dart';
import 'package:flutter/material.dart';

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, int index) {
              var article = state.result.articles[index];
              return CardArticle(
                article: article,

              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
