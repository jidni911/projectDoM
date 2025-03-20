import 'package:flutter/material.dart';
import 'package:project_dom/ui/attendence/attendence.dart';
import 'package:project_dom/ui/attendence/big_card.dart';
import 'package:project_dom/ui/attendence/history_list_view.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AttendencePageState>();
    var student = appState.current;
    var done = appState.done;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 10),
          if (!done) BigCard(student: student) else SmallCard(),
          SizedBox(height: 10),
          if (!done)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // appState.toggleAttendence(student);
                    appState.getNext(false);
                  },
                  icon: Icon(Icons.close, color: Colors.red, size: 30),
                  label: Text(
                    'Absent',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // appState.toggleAttendence(student);
                    appState.getNext(true);
                  },
                  icon: Icon(Icons.done, color: Colors.green, size: 30),
                  label: Text(
                    'Present',
                    style: TextStyle(color: Colors.green, fontSize: 30),
                  ),
                ),
              ],
            ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class SmallCard extends StatelessWidget {
  const SmallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: Text(
            "All Done",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
