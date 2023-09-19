import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/functions/db_functions.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/screens/widget_pages/checkbox_change.dart';
import 'package:todolist/screens/widget_pages/drawer.dart';
import 'package:todolist/screens/widget_pages/search%20bar.dart';
import 'package:todolist/theme/theme_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _taskController = TextEditingController();
  List<TaskModel> todolist = [];
  @override
  void initState() {
    super.initState();
    final taskDb = Hive.box<TaskModel>('task_db');
    todolist = taskDb.values.toList();
    taskListNotifier.value = todolist;
  }

  void deleteTask(int index) async {
    final taskDb = Hive.box<TaskModel>('task_db');
    await taskDb.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
      ),
      endDrawer: draWer(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.40),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: themeManager.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 10, child: AnimatedSearchBar()),
                  ],
                ),
              ),
              Positioned(
                top: 92,
                left: 11,
                child: Container(
                  width: 390,
                  height: 110,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: themeManager.pictureContainer,
                      borderRadius: BorderRadius.circular(70)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 185, 184, 184),
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Hello',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeManager.headingsColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Task's",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                    FloatingActionButton(
                      backgroundColor: themeManager.accentColor,
                      splashColor: Color.fromARGB(255, 240, 189, 48),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Add Task'),
                              content: TextFormField(
                                controller: _taskController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 4, 18, 94)),
                                )),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: Text('Add'),
                                    onPressed: () {
                                      setState(() {
                                        saveTask();
                                      });
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todolist.length,
              itemBuilder: (context, index) {
                final data = todolist[index];
                return Container(
                  width: 200,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          title: Text(
                            data.taskName,
                            style: TextStyle(),
                          ),
                          leading: CustomCheckbox(
                            value: data.tasComplete,
                            onChanged: (newvalue) {
                              checkBoxchanged(newvalue, index);
                              setState(() {
                                todolist[index];
                              });
                            },
                          ),
                          trailing: InkWell(
                              onTap: () {
                                deleteTask(index);
                                setState(() {
                                  todolist.removeAt(index);
                                });
                              },
                              child: Icon(Icons.delete)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveTask() async {
    final _task = _taskController.text.trim();
    final task = TaskModel(taskName: _task, tasComplete: false);
    await addtask(task);
  }

  void checkBoxchanged(bool? value, int index) async {
    final taskDb = Hive.box<TaskModel>('task_db');
    final task = taskDb.getAt(index);

    if (task != null) {
      task.tasComplete = value ?? false;
      await taskDb.putAt(index, task);
    }
  }
}
