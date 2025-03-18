import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<String> bgImages = [
    "assets/bg/morning_bg.jpg",
    "assets/bg/afternoon_bg.jpg",
    "assets/bg/evening_bg.jpg"
  ];

  List<String> badingTexts = ["Good Morning", "Good Afternoon", "Good Evening"];
  String username = "Jidni Khan";

  List<Task> tasks = [
    Task(
        id: 1,
        title: "Task 1",
        description: "Description for Task 1",
        isDone: false,
        dateTime: DateTime.now()),
    Task(
        id: 2,
        title: "Task 2",
        description: "Description for Task 2",
        isDone: true,
        dateTime: DateTime.now()),
    Task(
        id: 3,
        title: "Task 3",
        description: "Description for Task 3",
        isDone: false,
        dateTime: DateTime.now()),
  ];

  List<Task> officialSchedule = [
    Task(
        id: 1,
        title: "Task 1",
        description: "Description for Task 1",
        isDone: false,
        dateTime: DateTime.now()),
    Task(
        id: 2,
        title: "Task 2",
        description: "Description for Task 2",
        isDone: true,
        dateTime: DateTime.now()),
    Task(
        id: 3,
        title: "Task 3",
        description: "Description for Task 3",
        isDone: false,
        dateTime: DateTime.now()),
  ];

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startImageCycle();
  }

  void _startImageCycle() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % bgImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image with Animation
        AnimatedSwitcher(
          duration: Duration(seconds: 1), // Smooth fading animation
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Container(
            key: ValueKey<String>(
                bgImages[currentIndex]), // Ensures proper switching
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImages[currentIndex]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Foreground UI (Remains Static)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BadingTextWidget(
                    badingText: "${badingTexts[currentIndex]},\n$username"),
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                        children: [
                          ScheduleWidget(
                            tasks: officialSchedule,
                          ),
                          SizedBox(height: 10),
                          ToDoWidget(
                            tasks: tasks,
                          ),
                        ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                            child: ScheduleWidget(
                          tasks: officialSchedule,
                        )),
                        SizedBox(width: 10),
                        Expanded(
                            child: ToDoWidget(
                          tasks: tasks,
                        )),
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BadingTextWidget extends StatelessWidget {
  const BadingTextWidget({
    required this.badingText,
    super.key,
  });

  final String badingText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom: 50),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ), // Adjust padding for shape
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50), // Ensures pill shape
        ),
        child: Text(
          badingText,
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({required this.tasks, super.key});

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
                child: Text('To-Do List'),
              ),
            ),
          ),
          for (var task in tasks) ToDoItemWidget(task: task),
        ],
    );
  }
}

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
