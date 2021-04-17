import 'package:flutter_dicoding_fundamental/model_album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
