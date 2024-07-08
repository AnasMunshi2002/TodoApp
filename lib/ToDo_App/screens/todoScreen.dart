import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/ToDo_App/hive_database/hive_helper.dart';
import 'package:uuid/uuid.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}
/*

List<Task> _taskList = PrefManager.getTasks() ?? [];
*/

class _ToDoScreenState extends State<ToDoScreen> {
  final _mybox = Hive.box('taskBox');
  HiveHelper db = HiveHelper();

  final _taskController = TextEditingController();

  @override
  void initState() {
    if (_mybox.get('TASKLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      floatingActionButton: Container(
        width: 110,
        child: FloatingActionButton(
          onPressed: () {
            addTask();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.add),
              Text('Add Task'),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: db.taskList.isEmpty
            ? Center(child: Text('No Current Tasks'))
            : ListView.builder(
                itemCount: db.taskList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Card(
                      elevation: 0,
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            Expanded(
                              child: Container(
                                height: double.maxFinite,
                                child: IconButton(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.red)),
                                  onPressed: () {
                                    /*PrefManager.deleteTask(Task(
                                      taskName: db.taskList[index].taskName,
                                    ));
                                    setState(() {
                                      db.taskList =
                                          PrefManager.getTasks() ?? [];
                                    });*/
                                    setState(() {
                                      db.taskList.remove(db.taskList[index]);
                                    });

                                    db.updateDatabase();
                                  },
                                  icon: Icon(Icons.delete_forever_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: CheckboxListTile(
                          selected: db.taskList[index][1],
                          selectedTileColor: Colors.deepPurple.shade900,
                          value: db.taskList[index][1],
                          onChanged: (value) {
                            setState(() {
                              db.taskList[index][1] = value!;
                            });

                            db.updateDatabase();
                          },
                          title: Text(
                            db.taskList[index][0],
                            style: TextStyle(
                                decorationColor: Colors.deepPurple,
                                decorationThickness: 3,
                                decorationStyle: TextDecorationStyle.wavy,
                                decoration: db.taskList[index][1]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(6))
                  ],
                ),
              ),
      ),
    );
  }

  addTask() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Container(
            child: TextField(
                controller: _taskController,
                decoration: InputDecoration(border: OutlineInputBorder())),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FilledButton(
              onPressed: () {
                String taskName = _taskController.text.toString();
                var id = Uuid();
                if (taskName != '' || taskName.isNotEmpty) {
                  setState(() {
                    _taskController.text = '';
                    db.taskList.insert(0, [taskName, false]);
                  });
                  print(db.taskList);
                  print(_mybox.get('TASKLIST'));
                  /*PrefManager.setTasks(Task(
                    taskName: taskName,
                  ));*/

                  db.updateDatabase();
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: 'Please Enter a task');
                }
              },
              child: Text('ADD'),
            )
          ],
        );
      },
    );
  }
}
