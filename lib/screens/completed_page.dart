import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/functions/db_functions.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/screens/widget_pages/checkbox_change.dart';
import 'package:todolist/theme/theme_manager.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final currentDate = DateTime.now();
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
                _completedIcons(110, 70, Icons.sentiment_satisfied_rounded, 180,
                    themeManager.smileyColors),
                _completedIcons(110, 70, Icons.star, 40, Colors.amber),
                _completedIcons(275, 110, Icons.star, 30, Colors.amber),
                _completedIcons(125, 220, Icons.star, 30, Colors.amber),
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
                      "Completed",
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
                final completedTasks = todolist.where((task) {
                  return task.tasComplete &&
                      (currentDate.isBefore(task.date) ||
                          currentDate.isAtSameMomentAs(task.date) ||
                          isSameDay(currentDate, task.date));
                }).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      final data = completedTasks[index];
                      return Container(
                        width: 200,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: themeManager.completedTaskColors,
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
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${DateFormat('MM/dd/yyyy').format(data.date)}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    if (data.description != null &&
                                        data.description.isNotEmpty)
                                      Text(
                                        '${data.description}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                  ],
                                ),
                                leading: CustomCheckbox(
                                  value: data.tasComplete,
                                  onChanged: (newvalue) {
                                    if (newvalue == true) {
                                      addtask(data);
                                    }
                                  },
                                ),
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
      ),
    );
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
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
