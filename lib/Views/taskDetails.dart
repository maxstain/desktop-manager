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
  void initState() {
    super.initState();
    SharedData().tasks[widget.index].setProgressByTimeRemaining();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Details'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: LinearProgressIndicator(
                value: SharedData().tasks[widget.index].progress,
                color: Colors.deepPurple,
              ),
            ),
          )
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
    );
  }
}
