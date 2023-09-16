import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/screens/widget_pages/todolist.dart';

import '../theme/theme_manager.dart';

class Completed extends StatefulWidget {
  Completed({Key? key}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  List<TaskModel> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _initializeCompletedTasks();
  }

  void _initializeCompletedTasks() {
    // Assuming you have a Hive box for completed tasks, replace 'CompletedBox' with your actual box name
    final completedBox = Hive.box('Mybox');

    for (var i = 0; i < completedBox.length; i++) {
      final task = completedBox.getAt(i);
      setState(() {
        completedTasks.add(TaskModel(
          taskName: task['taskName'],
          tasComplete: task['taskComplete'],
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeManager.primaryColor,
        title: Text('Completed Tasks'),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(color: themeManager.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(300),bottomRight: Radius.circular(300))
            ),
          ),
           ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final taskModel = completedTasks[index];
      
            return toDolist(
              taskName: taskModel.taskName,
              tasComplete: taskModel.tasComplete,
              onChanged: (value) {
                return null;
              },
              deleteFunction: (context) {
                return null;
              },
            );
          },
        ),
        ],
      ),
    );
  }
}
