import 'package:desktop_manager/Shared/Data.dart';
import 'package:desktop_manager/Views/HomePage.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatefulWidget {
  final int index;
  const TaskDetailsPage({Key? key, required this.index}) : super(key: key);

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
            title: Text('Name: ${SharedData().tasks[widget.index].name}'),
            subtitle: Text(SharedData().tasks[widget.index].description),
          ),
          ListTile(
            title: const Text('Start Time'),
            subtitle: Text('${SharedData().tasks[widget.index].startTime}'
                .substring(0, 16)),
          ),
          ListTile(
            title: const Text('End Time'),
            subtitle: Text(
                '${SharedData().tasks[widget.index].endTime}'.substring(0, 16)),
          ),
        ],
      ),
      bottomSheet: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              setState(() {
                SharedData().completeTask(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task completed!'),
                  ),
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: const Text(
                'Completed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                SharedData().tasks.remove(SharedData().tasks[widget.index]);
                Navigator.pop(context);
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
