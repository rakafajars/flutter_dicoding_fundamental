import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dicoding_fundamental/file_dialo.dart';
import 'package:flutter_dicoding_fundamental/file_helper.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  // Membuat fierkasBaru
  void _createNewFile() {
    _titleController.clear();
    _contentController.clear();
  }

  bool get _isValid => _titleController.text.isNotEmpty;

  // menyimpan catatan dalam berkas
  void _saveFile(BuildContext context) async {
    if (_isValid) {
      final filePath = await FileHelper.getFilePath(_titleController.text);
      FileHelper.writeFile(filePath, _contentController.text);
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('File Saved'),
            actions: [
              CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'File Not Created',
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
            content: Text('File name must not be empty!'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
  }

  // fungsi menampilkan berkas yang telah disimpan
  void _getFilesInDirectory(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();

    final dir = Directory(directory.path);
    final files =
        dir.listSync().toList().where((file) => file.path.contains('text'));

    final FileSystemEntity selectedFile = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => FileDialog(
          files: files.toList(),
        ),
        fullscreenDialog: true,
      ),
    );

    if (selectedFile != null) {
      _openFile(selectedFile.path);
    }
  }

  // Untuk membaca berkas yang dipilih
  void _openFile(String filePath) async {
    final content = await FileHelper.readFile(filePath);
    _contentController.text = content;
    _titleController.text = split(filePath).last.split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('My Read Write File'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    child: Text('New File'),
                    onPressed: _createNewFile,
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: Text(
                      'Open File',
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    child: Text('Save File'),
                    onPressed: () {
                      _saveFile(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: CupertinoTextField(
                      placeholder: 'File Name',
                      controller: _titleController,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                child: CupertinoTextField(
                  placeholder: 'Write your notes here....',
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _contentController,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
