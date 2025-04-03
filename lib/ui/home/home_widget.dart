import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_dom/models/tasks.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/task_service.dart';
import 'package:project_dom/ui/home/bading_widget.dart';
import 'package:project_dom/ui/home/schedule_widget.dart';
import 'package:project_dom/ui/home/to_do_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    required this.user,
    super.key,
  });

  final User user;
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TaskService taskService = TaskService();
  List<String> bgImages = [
    "assets/bg/morning_bg.jpg",
    "assets/bg/afternoon_bg.jpg",
    "assets/bg/evening_bg.jpg"
  ];

  List<String> badingTexts = ["Good Morning", "Good Afternoon", "Good Evening"];
  User? user;

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

  List<Task> officialSchedule = [];

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startImageCycle();
    setState(() {
      user = widget.user;
    });
    taskService
        .getTasks()
        .then((value) => setState(() => officialSchedule = value));
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
                  badingText:
                      "${badingTexts[currentIndex]},\n${user?.fullName ?? 'Tester'}!",
                ),
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
