class Task {
  late final String name;
  late final String description;
  late final DateTime startTime;
  late final DateTime endTime;
  late bool isComplete;
  late int status; // 0 = not started, 1 = in progress, 2 = complete

  Task(
    this.name,
    this.description,
    this.startTime,
    this.endTime,
    this.status,
  ) {
    if (status == 0) {
      isComplete = false;
    } else if (status == 1) {
      isComplete = false;
    } else if (status == 2) {
      isComplete = true;
    } else {
      isComplete = false;
    }
  }

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        isComplete = json['isComplete'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'isComplete': isComplete,
        'status': status,
      };

  void start() {
    status = 1;
  }

  void complete() {
    isComplete = true;
  }
}
