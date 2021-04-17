import 'dart:convert';

import 'package:flutter_dicoding_fundamental/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '21e4d2bebfc8490383d42736ba2fbe4e';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ModelArticle> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");

    if (response.statusCode == 200) {
      return ModelArticle.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
