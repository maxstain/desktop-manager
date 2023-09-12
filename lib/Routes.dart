// This file contains all the names routes in the app. It is used to navigate between pages.

import 'package:desktop_manager/Views/HomePage.dart';
import 'package:desktop_manager/Views/TaskManagerPage.dart';
import 'package:desktop_manager/Views/DaysRemainingPage.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const HomePage());
    case '/taskManager':
      return MaterialPageRoute(builder: (context) => const TaskManagerPage());
    case '/daysRemaining':
      return MaterialPageRoute(builder: (context) => const DaysRemainingPage());
    case '/home':
      return MaterialPageRoute(builder: (context) => const HomePage());
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
