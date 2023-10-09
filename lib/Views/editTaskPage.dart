import 'package:desktop_manager/Repositories/Task.dart';
import 'package:flutter/material.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DateTime _startTimeController = widget.task.startTime;
  late DateTime _endTimeController = widget.task.endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return TextFormField(
                    controller: _nameController,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return TextFormField(
                    controller: _descriptionController,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blueGrey[700],
                  backgroundColor: Colors.blueGrey[100],
                ),
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then(
                    (value) {
                      if (value != null) {
                        setState(
                          () {
                            _startTimeController = DateTime(
                              _startTimeController.year,
                              _startTimeController.month,
                              _startTimeController.day,
                              value.hour,
                              value.minute,
                            );
                          },
                        );
                      }
                    },
                  );
                },
                child: _startTimeController.toString().isEmpty
                    ? const Text('Change Start Date')
                    : Text(
                        'Chosen start date: ${_startTimeController.hour}:${_startTimeController.minute}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blueGrey[700],
                  backgroundColor: Colors.blueGrey[100],
                ),
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then(
                    (value) {
                      if (value != null) {
                        setState(
                          () {
                            _endTimeController = DateTime(
                              _endTimeController.year,
                              _endTimeController.month,
                              _endTimeController.day,
                              value.hour,
                              value.minute,
                            );
                          },
                        );
                      }
                    },
                  );
                },
                child: _endTimeController.toString().isEmpty
                    ? const Text('Change End Date')
                    : Text(
                        'Chosen end date: ${_endTimeController.hour}:${_endTimeController.minute}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey[700],
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
                    Task newTask = Task(
                      name: _nameController.text == ''
                          ? widget.task.name
                          : _nameController.text,
                      description: _descriptionController.text == ''
                          ? widget.task.description
                          : _descriptionController.text,
                      startTime: _startTimeController,
                      endTime: _endTimeController,
                      isComplete: widget.task.isComplete,
                      status: widget.task.status,
                    );
                    widget.task.editTask(newTask);
                    Navigator.pop(context);
                  });
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
