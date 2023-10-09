import 'dart:io';
import 'package:desktop_manager/Repositories/Task.dart';
import 'package:desktop_manager/Shared/Data.dart';
import 'package:desktop_manager/Views/taskDetails.dart';
import 'package:desktop_manager/boxes.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

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
  double offset = 30;
  late int hours = SharedData().hours;
  late int minutes = SharedData().minutes;
  late List<Task> searchResults = [];
  static bool isOpened = false;
  TextEditingController searchController = TextEditingController();
  ExpandableController expandableController = ExpandableController(
    initialExpanded: isOpened,
  );

  void openAddTaskDialog() {
    if (Platform.isAndroid || Platform.isIOS) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: Form(
              child: ListView(
                shrinkWrap: true,
                children: [
                  FormField(
                    builder: (FormFieldState state) {
                      return TextFormField(
                        controller: nameController,
                        enableIMEPersonalizedLearning: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task name';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return TextFormField(
                        controller: descriptionController,
                        enableIMEPersonalizedLearning: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task description';
                          }
                          return null;
                        },
                      );
                    },
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
    } else {
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
            child: Form(
              child: ListView(
                children: [
                  FormField(
                    builder: (FormFieldState state) {
                      return TextFormField(
                        controller: nameController,
                        enableIMEPersonalizedLearning: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task name';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return TextFormField(
                        controller: descriptionController,
                        enableIMEPersonalizedLearning: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task description';
                          }
                          return null;
                        },
                      );
                    },
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
            ),
          );
        },
      );
    }
  }

  void completeTask(int index) {
    tasksBox.deleteAt(index);
  }

  void addTask(
    String name,
    String description,
    DateTime startTime,
    DateTime endTime,
  ) {
    Task task = Task(
      name: name,
      description: description,
      startTime: startTime,
      endTime: endTime,
      isComplete: false,
      status: 0,
    );

    tasksBox.put(
      "key_$name",
      task,
    );
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
    expandableController.addListener(() {
      isOpened = !isOpened;
    });
    setState(() {});
    _timer();
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            SharedData().isFree == false ? Colors.white : Colors.green,
        appBar: AppBar(
          scrolledUnderElevation: 1,
          elevation: 1,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(175 + 19),
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: SearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      setState(
                        () {
                          searchResults = tasksBox.values
                              .where((task) => task.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList() as List<Task>;
                        },
                      );
                    },
                    hintText: 'Search Tasks',
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - offset,
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    trailing: [
                      searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                searchResults.clear();
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : const Icon(Icons.search),
                    ],
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: tasksBox.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    openAddTaskDialog();
                  });
                },
                child: const Icon(Icons.add),
              ),
        body: tasksBox.isEmpty && searchResults.isEmpty
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
            : RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: searchResults.isEmpty
                      ? tasksBox.length
                      : searchResults.length,
                  itemBuilder: (context, index) {
                    Task task = searchResults.isEmpty
                        ? tasksBox.getAt(index)
                        : searchResults[index];
                    return task.isComplete == false
                        ? Container(
                            padding: const EdgeInsets.all(10),
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
                            child: ExpandablePanel(
                              header: Text(
                                task.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              collapsed: Text(
                                task.description,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              expanded: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'End time: ${task.endTime.hour}:${task.endTime.minute == 0 ? '00' : task.endTime.minute}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          task.status == 0
                                              ? 'Not Started'
                                              : task.status == 1
                                                  ? 'In Progress'
                                                  : 'Complete',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: task.status == 0
                                                ? Colors.red
                                                : task.status == 1
                                                    ? Colors.orange
                                                    : Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      completeTask(index);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                        task: task,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ));
  }
}
