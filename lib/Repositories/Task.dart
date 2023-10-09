import 'package:desktop_manager/boxes.dart';
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

  @override
  String toString() {
    return 'Task{name: $name, description: $description, startTime: $startTime, endTime: $endTime, isComplete: $isComplete, status: $status}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'isComplete': isComplete,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      description: map['description'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      isComplete: map['isComplete'],
      status: map['status'],
    );
  }

  /*
  * CopyWith method to create a new Task object with updated values
  *
  * @param name - String
  * @param description - String
  * @param startTime - DateTime
  * @param endTime - DateTime
  * @param isComplete - bool
  * @param status - int
  *
  * @return Task
  *
  */
  Task copyWith({
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? isComplete,
    int? status,
  }) {
    return Task(
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isComplete: isComplete ?? this.isComplete,
      status: status ?? this.status,
    );
  }

  /*
  * This function in used to compare two task objects
  */
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.name == name &&
        other.description == description &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.isComplete == isComplete &&
        other.status == status;
  }

  /*
   * This function in used to complete the current task object in the database 
   */
  void completeTask() {
    isComplete = true;
    status = 2;
  }

  /*
  * This function in used to edit the current task object in the database
  */
  void editTask(Task newTask) {
    name = newTask.name;
    description = newTask.description;
    startTime = newTask.startTime;
    endTime = newTask.endTime;
    status = newTask.status;
    isComplete = newTask.isComplete;
    tasksBox.putAt(tasksBox.values.toList().indexOf(this), this);
  }

  /*
  * This function in used to start the current task object in the database
  */
  void startTask() {
    status = 1;
    tasksBox.putAt(tasksBox.values.toList().indexOf(this), this);
  }

  /*
  * This function in used to pause the current task object in the database
  */
  void pauseTask() {
    status = 0;
    tasksBox.putAt(tasksBox.values.toList().indexOf(this), this);
  }

}
