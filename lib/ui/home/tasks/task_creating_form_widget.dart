import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/service/task_service.dart';

class TaskCreatingFormWidget extends StatelessWidget {
  const TaskCreatingFormWidget(
      {required this.loadTasks, required this.task, super.key});

  final Function loadTasks;
  final Task? task;

  void afterWork(Task? value, BuildContext context) {
    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Done"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController taskTitleController =
            TextEditingController(text: task?.title),
        taskDescriptionController =
            TextEditingController(text: task?.description),
        taskDateTimeController =
            TextEditingController(text: task?.dateTime.toString());
    DateTime dateTime = task != null ? task!.dateTime : DateTime.now();
    return Container(
      padding: EdgeInsets.all(16),
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(task == null ? "Create" : "Update"),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
            controller: taskTitleController,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
            controller: taskDescriptionController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  controller: taskDateTimeController,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(dateTime),
                      );
                      if (time != null) {
                        dateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                        // final textEditingController = context
                        //     .findAncestorWidgetOfExactType<TextField>()
                        //     ?.controller as TextEditingController;
                        taskDateTimeController.text = dateTime.toString();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Task newTask = Task(
                      id: task?.id,
                      title: taskTitleController.text,
                      description: taskDescriptionController.text,
                      isDone: task?.isDone ?? false,
                      dateTime: dateTime,
                      taskType: TaskType.private);
                  task == null
                      ? TaskService().createTask(newTask).then((value) {
                          afterWork(value, context);
                        })
                      : TaskService().updateTask(newTask).then((value) {
                          afterWork(value, context);
                        });
                  Navigator.pop(context);
                  loadTasks();
                },
                child: Text("Save"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              )
            ],
          )
        ],
      ),
    );
  }
}
