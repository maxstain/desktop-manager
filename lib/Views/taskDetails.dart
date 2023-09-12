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
  void refresh() {
    Future.delayed(const Duration(seconds: 1), () {
      SharedData().tasks[widget.index].setProgressByTimeRemaining();
      refresh();
    });
  }

  @override
  void initState() {
    super.initState();
    SharedData().tasks[widget.index].setProgressByTimeRemaining();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Column(
            children: [
              Text(
                'Progress: ${SharedData().tasks[widget.index].progress * 100}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LinearProgressIndicator(
                value: SharedData().tasks[widget.index].progress,
                color: Colors.deepPurple,
                minHeight: 10.0,
                backgroundColor: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name: ${SharedData().tasks[widget.index].name}'),
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
                SharedData().completeTask(context, index);
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
