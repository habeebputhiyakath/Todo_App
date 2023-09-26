
import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';
@HiveType(typeId: 1)
class TaskModel  {
  @HiveField(0)
  late String taskName;
  @HiveField(1)
  late bool tasComplete;
  @HiveField(2)
  late DateTime date;
  @HiveField(3)
  late String description;

  TaskModel({
    required this.taskName,
    required this.tasComplete,
    required this.date,
    required this.description,
  });

 
}