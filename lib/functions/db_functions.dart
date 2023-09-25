import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/data_model.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);
Future<void> addtask(TaskModel value) async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  await taskDb.add(value);
  taskListNotifier.value.add(value);
  taskListNotifier.notifyListeners();
}
  Future<void> getAlltasks() async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  taskListNotifier.value.clear();
  taskListNotifier.value.addAll(taskDb.values);
  taskListNotifier.notifyListeners();
}
 Future<void> deleteTask(int index) async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  await taskDb.deleteAt(index);
  taskListNotifier.value.removeAt(index); 
  taskListNotifier.notifyListeners();
}
Future<void> updateTask(int index, TaskModel updatedTask) async {
  final taskDb = await Hive.openBox<TaskModel>('task_db');
  await taskDb.putAt(index, updatedTask);
  taskListNotifier.value[index] = updatedTask;
  taskListNotifier.notifyListeners();
}
  Uint8List? getStoredImage() {
  final profilePictureBox = Hive.box('profile_picture_box');
  final imageBytes = profilePictureBox.get('profile_image');
  return imageBytes as Uint8List?;
}
  void storeImageInHive(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final profilePictureBox = Hive.box('profile_picture_box');
    await profilePictureBox.put('profile_image', imageBytes);
}

