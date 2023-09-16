import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/data_model.dart';

Future<void> addTask(TaskModel value) async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  await taskDb.add(value);
}