import 'package:flutter/material.dart';

class EditTaskPage extends StatefulWidget {
  EditTaskPage({Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
