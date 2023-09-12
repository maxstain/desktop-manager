class Task {
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isComplete;

  Task(
    this.name,
    this.description,
    this.startTime,
    this.endTime,
    this.isComplete,
  );

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        isComplete = json['isComplete'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'isComplete': isComplete,
      };
}
