import 'package:desktop_manager/Shared/Data.dart';
import 'package:desktop_manager/Views/taskDetails.dart';
import 'package:flutter/material.dart';

class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({Key? key}) : super(key: key);

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  void checker() {
    setState(() {
      if (DateTime.now().weekday == DateTime.saturday ||
          DateTime.now().weekday == DateTime.sunday) {
        SharedData().isFree = true;
        SharedData().isWeekend = true;
      } else if (DateTime.now().hour >= 18) {
        SharedData().isFree = true;
      } else if (DateTime.now().hour < 9) {
        SharedData().isFree = true;
      } else if (DateTime.now().month == 7 || DateTime.now().month == 8) {
        if (DateTime.now().hour >= 16) {
          SharedData().isFree = true;
        } else {
          SharedData().isFree = false;
        }
      }
      if (DateTime(2028, 12, 19) == DateTime.now()) {
        SharedData().isLastDay = true;
      } else {
        SharedData().isFree = false;
      }
    });
  }

  void _timer() {
    Future.delayed(const Duration(seconds: 1), () {
      checker();
      _timer();
    });
  }

  @override
  void initState() {
    super.initState();
    _timer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double offset = 30;
    late int hours = SharedData().hours;
    late int minutes = SharedData().minutes;
    return Scaffold(
        backgroundColor:
            SharedData().isFree == false ? Colors.white : Colors.green,
        appBar: AppBar(
          scrolledUnderElevation: 1,
          elevation: 1,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: const Text(
                    'Task Manager',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SharedData().isFree == false
                        ? Colors.white
                        : Colors.green,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  width: MediaQuery.of(context).size.width - offset,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        // Time until clocking out (6:00 PM)
                        'Time until clocking out:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      hours > 0
                          ? Text(
                              '$hours hours '
                              '$minutes minutes',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Text(
                              '$minutes minutes',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SharedData().tasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'No tasks added yet!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/addTask');
                      },
                      child: const Text('Add Task'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: SharedData().tasks.length,
                itemBuilder: (context, index) {
                  return SharedData().tasks[index].isComplete == false
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: ListTile(
                            title: Text(
                              SharedData().tasks[index].name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              SharedData().tasks[index].description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: IconButton(
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
                              icon: const Icon(
                                  Icons.check_circle_outline_rounded),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailsPage(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container();
                },
              ));
  }
}
