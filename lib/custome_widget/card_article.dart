import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/common/navigation.dart';
import 'package:flutter_dicoding_fundamental/common/style.dart';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';
import 'package:flutter_dicoding_fundamental/ui/detail_article.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: article.urlToImage == null
            ? Container(
                width: 100,
                child: Icon(
                  Icons.error,
                ),
              )
            : Hero(
                tag: article.urlToImage,
                child: Image.network(
                  article.urlToImage,
                  width: 100,
                ),
              ),
        title: Text(
          article.title ?? "",
        ),
        onTap: () => Navigation.intentWithData(
          ArticleDetailPage.routeName,
          article,
        ),
      ),
    );
  }
}
