import 'package:flutter/cupertino.dart';

class DoneModuleProvider extends ChangeNotifier {
  final List<String> _doneModuleList = [];

  List<String> get doneModuleList => _doneModuleList;

  void complete(String moduleName) {
    _doneModuleList.add(moduleName);
    /// NotifyListener merukapan widget yang
    /// memberitahukan bahwa telah tarjadinya perubahan
    /// sehingga harus membangun ulang widget
    notifyListeners();
  }
}