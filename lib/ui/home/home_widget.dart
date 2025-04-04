import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/ui/home/bading_widget.dart';
import 'package:project_dom/ui/home/schedule_widget.dart';
import 'package:project_dom/ui/home/tasks/to_do_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

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
  User? user;

  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      DateTime now = DateTime.now();
      int hour = now.hour;
      if (hour < 12) {
        currentIndex = 0;
      } else if (hour < 17) {
        currentIndex = 1;
      } else {
        currentIndex = 2;
      }
    });

    refreshUser();
  }

  Future<void> refreshUser() async {
    AuthService().getProfileLocal().then((value) => setState(() {
          user = value;
        }));
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
        ),
      ],
    );
  }
}
