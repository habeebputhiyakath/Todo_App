import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/functions/db_functions.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/screens/widget_pages/checkbox_change.dart';
import 'package:todolist/screens/widget_pages/todolist.dart';

import '../theme/theme_manager.dart';

class UnComplete extends StatefulWidget {
  const UnComplete({super.key});

  @override
  State<UnComplete> createState() => _UnCompleteState();
}

class _UnCompleteState extends State<UnComplete> {
  List<TaskModel> completedTasks = [];
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: 315,
          decoration: BoxDecoration(
            color: themeManager.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.40),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Stack(
            children: [
              _completedIcons(110, 70, Icons.sentiment_dissatisfied_rounded,
                  180, themeManager.smileyColors),
              _completedIcons(110, 70, Icons.water_drop, 40, Colors.cyan),
              _completedIcons(275, 110, Icons.water_drop, 30, Colors.cyan),
              _completedIcons(125, 220, Icons.water_drop, 30, Colors.cyan),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: themeManager.headingsColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Incomplete",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        Builder(builder: (context) {
          return ValueListenableBuilder(
            valueListenable: taskListNotifier,
            builder:
                (BuildContext ctx, List<TaskModel> todolist, Widget? child) {
              final incompleteTasks =
                  todolist.where((task) => !task.tasComplete).toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: incompleteTasks.length,
                  itemBuilder: (context, index) {
                    final data = incompleteTasks[index];
                    return Container(
                      width: 200,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: themeManager.incompletedTaskColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ListTile(
                              title: Text(
                                data.taskName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: CustomCheckbox(
                                value: data.tasComplete,
                                onChanged: (newvalue) {
                                  if (newvalue==false) {
                                    setState(() {
                                      addtask(data);
                                    });
                                  }
                                },
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    setState(() {
                                      deleteTask(index);
                                    });
                                      incompleteTasks.removeAt(index); 
                                    
                                  },
                                  child: Icon(Icons.delete)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }),
      ],
    ));
  }

  Positioned _completedIcons(
      double left, double top, IconData icon, double iconSize, Color color) {
    return Positioned(
        left: left,
        top: top,
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ));
  }
}
