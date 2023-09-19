import 'package:desktop_manager/Repositories/Task.dart';
import 'package:desktop_manager/Routes.dart';
import 'package:desktop_manager/Shared/Data.dart';
import 'package:desktop_manager/Views/HomePage.dart';
import 'package:desktop_manager/boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  tasksBox = await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SharedData().timer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desktop Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: Routes.routes,
    );
  }
}
