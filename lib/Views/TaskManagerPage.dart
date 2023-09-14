import 'dart:io';

import 'package:desktop_manager/Models/Task.dart';
import 'package:desktop_manager/Shared/Data.dart';
import 'package:desktop_manager/Views/taskDetails.dart';
import 'package:flutter/material.dart';

class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({Key? key}) : super(key: key);

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime startTimeController;
  late DateTime endTimeController;

  late final List<Task> tasks = [
    // Task(
    //   'Data Dictionary',
    //   'Correct the data dictionary that MGR revised',
    //   DateTime(2023, 9, 12, 9),
    //   DateTime(2023, 9, 12, 17),
    //   false,
    // ),
  ];

  void openAddTaskDialog() {
    if (Platform.isAndroid || Platform.isIOS) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Task Description',
                  ),
                ),
                Row(
                  children: [
                    const Text('Start Time: '),
                    ElevatedButton(
                      onPressed: () async {
                        startTimeController = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          return DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value!.hour,
                            value.minute,
                          );
                        });
                      },
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('End Time: '),
                    ElevatedButton(
                      onPressed: () async {
                        endTimeController = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          return DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value!.hour,
                            value.minute,
                          );
                        });
                      },
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  nameController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    addTask(
                      nameController.text,
                      descriptionController.text,
                      startTimeController,
                      endTimeController,
                    );
                    nameController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  });
                },
                child: const Text('Add Task'),
              ),
            ],
          );
        },
      );
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      showBottomSheet(
        backgroundColor: Colors.grey[100],
        enableDrag: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Task Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      const Text('Start Time: '),
                      ElevatedButton(
                        onPressed: () async {
                          startTimeController = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            return DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              value!.hour,
                              value.minute,
                            );
                          });
                        },
                        child: const Text('Select Time'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      const Text('End Time: '),
                      ElevatedButton(
                        onPressed: () async {
                          endTimeController = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            return DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              value!.hour,
                              value.minute,
                            );
                          });
                        },
                        child: const Text('Select Time'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          addTask(
                            nameController.text,
                            descriptionController.text,
                            startTimeController,
                            endTimeController,
                          );
                          nameController.clear();
                          descriptionController.clear();
                        });
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Add Task'),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          nameController.clear();
                          descriptionController.clear();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void completeTask(int index) {
    tasks.removeAt(index);
  }

  void addTask(
      String name, String description, DateTime startTime, DateTime endTime) {
    Task task = Task(name, description, startTime, endTime, 0);
    tasks.add(task);
  }

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
        floatingActionButton: tasks.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    openAddTaskDialog();
                  });
                },
                child: const Icon(Icons.add),
              ),
        body: tasks.isEmpty
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
                        openAddTaskDialog();
                      },
                      child: const Text('Add Task'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return tasks[index].isComplete == false
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
                              tasks[index].name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  tasks[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  '${tasks[index].startTime.hour}:${tasks[index].startTime.minute} - ${tasks[index].endTime.hour}:${tasks[index].endTime.minute}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  completeTask(index);
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
                                    task: tasks[index],
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
