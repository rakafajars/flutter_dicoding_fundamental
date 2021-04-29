import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper {
  // Menuliskan data ke dalam berkas
  static Future<File> writeFile(String path, String content) async {
    final file = File(path);

    // Menulis konten dalam berkas
    print('saved to $path');
    return file.writeAsString('$content');
  }

  // Mebaca berkas
  static Future<String> readFile(String filePath) async {
    try {
      final file = File(filePath);

      // membaca berkas sebagai sebuah string.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      print(e);
      return '';
    }
  }

  // method mengembalikan lokasi berkas
  static Future<String> getFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final prefix = directory.path;
    final absolutePath = '$prefix/$filename.txt';
    return absolutePath;
  }
}
