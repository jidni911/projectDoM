import 'dart:async';
import 'package:flutter/material.dart';

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

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startImageCycle();
  }

  void _startImageCycle() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BadingTextWidget(badingText: badingTexts[currentIndex]),
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      ScheduleWidget(),
                      SizedBox(height: 10),
                      ToDoWidget(),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(child: ScheduleWidget()),
                      SizedBox(width: 10),
                      Expanded(child: ToDoWidget()),
                    ],
                  );
                }
              })
            ],
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
            horizontal: 20, vertical: 10), // Adjust padding for shape
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50), // Ensures pill shape
        ),
        child: Text(
          badingText,
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({super.key});

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
        Text('TODOs'),
      ],
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

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
        Text('Schedule Details'),
      ],
    );
  }
}
