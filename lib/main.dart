import 'package:desktop_manager/Views/HomePage.dart';
import 'package:flutter/material.dart';

void timer() {
  Future.delayed(const Duration(seconds: 1), () {
    timer();
  });
}

void main() {
  runApp(const MyApp());
  timer();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
