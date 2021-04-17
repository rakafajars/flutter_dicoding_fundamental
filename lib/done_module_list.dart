import 'package:flutter/material.dart';

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;
  DoneModuleList({@required this.doneModuleList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Module List'),
      ),
      body: ListView.builder(
        itemCount: doneModuleList.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(
              doneModuleList[index],
            ),
          );
        },
      ),
    );
  }
}

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;

  ModuleList({this.doneModuleList});

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> moduleList = [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Memulai Pemrograman dengan Dart',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moduleList.length,
      itemBuilder: (context, int index) {
        return ModuleTile(
          moduleName: moduleList[index],
          isDone: doneModuleList.contains(moduleList[index]),
          onClick: () {
            setState(
              () {
                doneModuleList.add(
                  moduleList[index],
                );
              },
            );
          },
        );
      },
    );
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function onClick;

  ModuleTile({
    this.moduleName,
    this.isDone,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? Icon(Icons.done)
          : RaisedButton(
              child: Text('Done'),
              onPressed: onClick,
            ),
    );
  }
}
