import 'package:desktop_manager/Models/Task.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task task;
  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name: ${widget.task.name}'),
            subtitle: Text(widget.task.description),
          ),
          ListTile(
            title: const Text('Start Time'),
            subtitle: Text('${widget.task.startTime}'.substring(0, 16)),
          ),
          ListTile(
            title: const Text('End Time'),
            subtitle: Text('${widget.task.endTime}'.substring(0, 16)),
          ),
        ],
      ),
    );
  }
}
