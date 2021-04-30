import 'dart:convert';
import 'package:flutter_dicoding_fundamental/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '81d98da5c83d45a5ad24b6ab1698e745';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
