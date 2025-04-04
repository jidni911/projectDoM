import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/service/task_service.dart';
import 'package:project_dom/ui/home/tasks/to_do_item_widget.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  TaskService taskService = TaskService();
  List<Task> tasks = [];
  void loadTasks() {
    taskService.getTasks().then((value) => setState(() => tasks = value));
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void doTask(int taskId) async {
    final task = tasks.firstWhere((task) => task.id == taskId);
    final newTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      isDone: !task.isDone,
      dateTime: task.dateTime,
      taskType: task.taskType,
    );
    await taskService.createTask(newTask);
    loadTasks();
  }

  void editTask(int taskId) {
    //TODO
  }

  void deleteTask(int taskId) async {
    await taskService.deleteTask(taskId);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [];
    return Column(
      children: [
        Container(
          color: Colors.amber,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Official Schedule'),
            ),
          ),
        ),
        for (var task in tasks)
          ToDoItemWidget(
            doTask: doTask,
            editTask: editTask,
            deleteTask: deleteTask,
            task: task,
          ),
      ],
    );
  }
}
