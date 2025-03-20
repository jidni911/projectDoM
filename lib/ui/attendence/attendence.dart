import 'package:flutter/material.dart';
import 'package:project_dom/models/students.dart';
import 'package:project_dom/ui/attendence/attended_page.dart';
import 'package:project_dom/ui/attendence/generator_page.dart';
import 'package:provider/provider.dart';

class AttendencePage extends StatelessWidget {
  const AttendencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendencePageState(),
      child: const AttendenceHomePage(),
    );
  }
}

class AttendencePageState extends ChangeNotifier {
  List<Student> studentList = demoStudents;
  int studentIndex = 0;
  var current = demoStudents[0];
  var history = <Student>[];
  var done = false;
  GlobalKey? historyListKey;

  void getNext(bool present) {
    if (done) return;
    if (present) toggleAttendence();
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    if (studentIndex == studentList.length - 1) {
      done = true;
    } else {
      current = studentList[++studentIndex];
    }
    notifyListeners();
  }

  var attended = <Student>[];

  void toggleAttendence([Student? student]) {
    student = student ?? current;
    if (attended.contains(student)) {
      attended.remove(student);
    } else {
      attended.add(student);
      attended.sort((a, b) => a.classRoll.compareTo(b.classRoll));
    }
    notifyListeners();
  }

  void removeAttendence(Student student) {
    attended.remove(student);
    notifyListeners();
  }
}

class AttendenceHomePage extends StatefulWidget {
  const AttendenceHomePage({super.key});

  @override
  State<AttendenceHomePage> createState() => _AttendenceHomePageState();
}

class _AttendenceHomePageState extends State<AttendenceHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();

      case 1:
        page = AttendedPage();

      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: 'Summary',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list),
                        label: Text('Summary'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
