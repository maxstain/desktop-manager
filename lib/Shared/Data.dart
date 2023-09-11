// Shared variables
import 'package:flutter/material.dart';

class SharedData {
  bool isWeekend = false;
  bool isFree = false;
  bool isLastDay = false;
  int hours = const TimeOfDay(hour: 15, minute: 00).hour - TimeOfDay.now().hour;
  int minutes =
      const TimeOfDay(hour: 16, minute: 60).minute - TimeOfDay.now().minute;
  int seconds = 0;
  double offset = 30;

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.lock_clock_rounded),
      label: 'Clock Out Time',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_rounded),
      label: 'Total Days Remaining',
    ),
  ];

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

// Path: lib/Views/DaysRemainingPage.dart
// Path: lib/Views/ClockOutPage.dart
// Path: lib/Views/HomePage.dart
// Path: lib/Views/SettingsPage.dart
// Path: lib/Views/SignInPage.dart
// Path: lib/Views/SignUpPage.dart
// Path: lib/Views/WelcomePage.dart
// Path: lib/Views/SplashPage.dart
