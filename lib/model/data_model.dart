import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';
@HiveType(typeId: 1)
class TaskModel  {
  @HiveField(0)
  final String taskName;
   @HiveField(1)
  final bool tasComplete;

  TaskModel({
    required this.taskName,
    required this.tasComplete,
  });
}