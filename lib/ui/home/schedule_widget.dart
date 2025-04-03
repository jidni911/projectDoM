import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/ui/home/to_do_item_widget.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({required this.tasks, super.key});
  final List<Task> tasks;

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
              child: Text('Official Schedule'),
            ),
          ),
        ),
        for (var task in tasks) ToDoItemWidget(task: task),
      ],
    );
  }
}
