import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  List taskList = [];

  final _myBox = Hive.box('taskBox');

  void createInitialData() {
    taskList = [
      ['Sample Task', false],
      ['Add a new Task', false],
    ];
  }

  void loadData() {
    taskList = _myBox.get('TASKLIST')!;
  }

  void updateDatabase() {
    _myBox.put('TASKLIST', taskList);
  }
}
