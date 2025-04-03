import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';

class ToDoItemWidget extends StatelessWidget {
  const ToDoItemWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
              task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary), //Checkbox(value: task.isDone, onChanged: null),
          title: Text(
            task.title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          subtitle: Text(
            task.description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formatDateTime(task.dateTime),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  semanticLabel: 'Edit',
                  color: Colors.orangeAccent,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  semanticLabel: 'Delete',
                  color: Colors.redAccent,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year}\n${dateTime.hour}:${dateTime.minute}';
  }
}
