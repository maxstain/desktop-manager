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
}

// Path: lib/Views/DaysRemainingPage.dart
// Path: lib/Views/ClockOutPage.dart
// Path: lib/Views/HomePage.dart
// Path: lib/Views/SettingsPage.dart
// Path: lib/Views/SignInPage.dart
// Path: lib/Views/SignUpPage.dart
// Path: lib/Views/WelcomePage.dart
// Path: lib/Views/SplashPage.dart
