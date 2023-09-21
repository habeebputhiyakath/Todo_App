
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/home_page.dart';
part 'data_model.g.dart';
@HiveType(typeId: 1)
class TaskModel  {
  @HiveField(0)
  late String taskName;
  @HiveField(1)
  late bool tasComplete;

  TaskModel({
    required this.taskName,
    required this.tasComplete,
  });

 
}