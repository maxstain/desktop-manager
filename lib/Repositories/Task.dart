import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 1)
class Task {
  Task({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.isComplete,
    required this.status,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime startTime;

  @HiveField(3)
  DateTime endTime;

  @HiveField(4)
  bool isComplete;

  @HiveField(5)
  int status;
}
