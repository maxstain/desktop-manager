// Shared variables
import 'package:flutter/material.dart';

class SharedData {
  bool isWeekend = false;
  bool isFree = false;
  bool isLastDay = false;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  double offset = 30;

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.lock_clock_rounded),
      label: 'Task Manager',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_rounded),
      label: 'Total Days Remaining',
    ),
  ];

  SharedData() {
    if (DateTime.now().weekday == DateTime.saturday ||
        DateTime.now().weekday == DateTime.sunday) {
      isFree = true;
      isWeekend = true;
    } else if (DateTime.now().hour >= 18) {
      isFree = true;
    } else if (DateTime.now().hour < 9) {
      isFree = true;
    } else if (DateTime.now().month == 7 || DateTime.now().month == 8) {
      hours = const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
      minutes =
          const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
      if (DateTime.now().hour >= 16) {
        isFree = true;
      } else {
        isFree = false;
      }
    } else {
      hours = const TimeOfDay(hour: 17, minute: 00).hour - TimeOfDay.now().hour;
      minutes =
          const TimeOfDay(hour: 18, minute: 60).minute - TimeOfDay.now().minute;
    }
    if (DateTime(2028, 12, 19) == DateTime.now()) {
      isLastDay = true;
    } else {
      isFree = false;
    }
  }

  void checker() {
    if (DateTime.now().weekday == DateTime.saturday ||
        DateTime.now().weekday == DateTime.sunday) {
      isFree = true;
      isWeekend = true;
    } else if (DateTime.now().hour >= 18) {
      isFree = true;
    } else if (DateTime.now().hour < 9) {
      isFree = true;
    } else if (DateTime.now().month == 7 || DateTime.now().month == 8) {
      if (DateTime.now().hour >= 16) {
        isFree = true;
      } else {
        isFree = false;
      }
    }
    if (DateTime(2028, 12, 19) == DateTime.now()) {
      isLastDay = true;
    } else {
      isFree = false;
    }
  }

  // Shared functions
  void timer() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        timer();
        checker();
      },
    );
  }
}
