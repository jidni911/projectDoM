import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/service/task_service.dart';
import 'package:project_dom/ui/home/tasks/task_creating_form_widget.dart';
import 'package:project_dom/ui/home/tasks/to_do_item_widget.dart';

class ToDoWidget extends StatefulWidget {
  const ToDoWidget({super.key});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
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

  void showBottomModal(BuildContext context, [Task? task]) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return TaskCreatingFormWidget(loadTasks: loadTasks, task: task);
      },
    );
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
    await taskService.updateTask(newTask);
    loadTasks();
  }

  void editTask(int taskId) async {
    Task? task = await taskService.getTaskById(taskId);
    if (task == null) print("null");
    showBottomModal(context, task);
  }

  void deleteTask(int taskId) async {
    bool v = await taskService.deleteTask(taskId);
    if (v) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Deleted"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
        ),
      );
    }
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('To-Do List'),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showBottomModal(context);
              },
              icon: Icon(Icons.add),
              label: Text('Add'),
            )
          ],
        )
      ],
    );
  }
}
