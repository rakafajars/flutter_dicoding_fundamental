import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/api_service.dart';
import 'package:flutter_dicoding_fundamental/model_album.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar'),
      ),
      body: Center(
        child: FutureBuilder(
          /// sebuah fungsi yang ingin dikerjakan
          future: _futureAlbum,
          /// builder akan memberitahu apa yang harus ditampilakn,
          /// ketika fungsi future selesai dikerjakan
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            if(state != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if(snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else {
                return Text('');
              }
            }
          },
        ),
      ),
    );
  }
}
