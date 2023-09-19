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

  void completeTask() {
    isComplete = true;
    status = 2;
  }

  void startTask() {
    status = 1;
  }
}
