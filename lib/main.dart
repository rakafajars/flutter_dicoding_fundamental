import 'package:flutter/material.dart';
import 'package:flutter_dicoding_fundamental/done_module_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ModulePage(),
    );
  }
}

class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memulai Pemrograman Dengan Dart'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoneModuleList(
                    doneModuleList: doneModuleList,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ModuleList(
        doneModuleList: doneModuleList,
      ),
    );
  }
}
