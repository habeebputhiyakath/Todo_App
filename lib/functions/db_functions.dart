import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/data_model.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);
Future<void> addtask(TaskModel value) async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  await taskDb.add(value);
  taskListNotifier.value.add(value);
  taskListNotifier.notifyListeners();

Future<void> addCheck(int id, TaskModel data) async {
  final tododb = await Hive.openBox<TaskModel>('task_db');
  await tododb.putAt(id, data);
}
Future<void> deleteTask(int index) async {
  final studentDb = await Hive.openBox<TaskModel>('task_db');
  await studentDb.deleteAt(index);
  
  }

}