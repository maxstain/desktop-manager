class Task {
  late final String name;
  late final String description;
  late final DateTime startTime;
  late final DateTime endTime;
  late bool isComplete;
  late double progress = 0;

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

  set setName(String name) {
    this.name = name;
  }

  set setDescription(String description) {
    this.description = description;
  }

  set setStartTime(DateTime startTime) {
    this.startTime = startTime;
  }

  set setEndTime(DateTime endTime) {
    this.endTime = endTime;
  }

  void setProgressByTimeRemaining() {
    if (DateTime.now().isAfter(endTime)) {
      progress = 1;
    } else {
      progress = DateTime.now().difference(startTime).inSeconds /
          endTime.difference(startTime).inSeconds;
    }
  }

  void complete() {
    isComplete = true;
  }
}
