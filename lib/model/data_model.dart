import 'package:hive_flutter/hive_flutter.dart';

class Tasks extends HiveObject{
  @HiveField(0)
  late final String taskName;
  @HiveField(1)
  late final bool tasComplete;

  Tasks({
    required this.taskName,
    required this.tasComplete
  });
}