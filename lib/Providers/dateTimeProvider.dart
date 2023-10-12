import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(const Duration(hours: 1));

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;

  DateTimeProvider({required DateTime startTime, required DateTime endTime})
      : _startTime = startTime,
        _endTime = endTime;

  void setStartTime(DateTime newStartTime) {
    _startTime = newStartTime;
    notifyListeners();
  }

  void setEndTime(DateTime newEndTime) {
    _endTime = newEndTime;
    notifyListeners();
  }

  void reset() {
    _startTime = DateTime.now();
    _endTime = DateTime.now().add(const Duration(hours: 1));
    notifyListeners();
  }
}
