import 'package:desktop_manager/Shared/Data.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatefulWidget {
  final int index;
  const TaskDetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SharedData().tasks[widget.index].name),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(SharedData().tasks[widget.index].name),
            subtitle: Text(SharedData().tasks[widget.index].description),
          ),
          ListTile(
            title: const Text('Start Time'),
            subtitle: Text('${SharedData().tasks[widget.index].startTime}'),
          ),
          ListTile(
            title: const Text('End Time'),
            subtitle: Text('${SharedData().tasks[widget.index].endTime}'),
          ),
        ],
      ),
    );
  }
}
