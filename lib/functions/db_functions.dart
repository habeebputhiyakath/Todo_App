// import 'package:flutter/widgets.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todolist/model/data_model.dart';

// ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);
// Future<void> addTask(TaskModel value) async {
//   final taskDb = await Hive.openBox<TaskModel>('task_db');
//   await taskDb.add(value);
//   taskListNotifier.value.add(value);
//   taskListNotifier.notifyListeners();
// }