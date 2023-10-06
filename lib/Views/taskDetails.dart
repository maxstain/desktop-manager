import 'package:desktop_manager/Repositories/Task.dart';
import 'package:desktop_manager/Views/editTaskPage.dart';
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
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    setState(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Name: ${widget.task.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.task.description),
          ),
          ListTile(
            title: const Text(
              'Start Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.task.startTime}'.substring(0, 16)),
          ),
          ListTile(
            title: const Text(
              'End Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.task.endTime}'.substring(0, 16)),
          ),
          ListTile(
            title: const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.task.status == 0
                  ? 'Not Started'
                  : widget.task.status == 1
                      ? 'In Progress'
                      : 'Complete',
              style: TextStyle(
                color: widget.task.status == 0
                    ? Colors.red
                    : widget.task.status == 1
                        ? Colors.orange
                        : Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    widget.task.startTask();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task Started'),
                      ),
                    );
                    Navigator.pop(context);
                  });
                },
                child: const Text('Start'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    widget.task.completeTask();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task Completed'),
                      ),
                    );
                  });
                  Navigator.pop(context);
                },
                child: const Text('Complete'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskPage(
                      task: widget.task,
                    ),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }
}
