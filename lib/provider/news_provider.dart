import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/data/api/api_service.dart';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';

/// Untuk mengatur setiap proses yang akan dijalankan di dalam fungsi _fetchAllArticle()
/// sehingga dapat menampilakn kondisi state yang ada dlam keadaan
/// Loading, NOData, HasData, Error
enum ResultState { Loading, NoData, HasData, Error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({@required this.apiService}) {
    _fetchAllArticle();
  }

  ModelArticle _articlesResult;
  String _message = '';
  ResultState _state;

  String get message => _message;

  ModelArticle get result => _articlesResult;

  ResultState get state => _state;

  /// Future dynamic
  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}