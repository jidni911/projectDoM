import 'package:flutter/material.dart';
import 'package:project_dom/ui/attendence/attendence.dart';
import 'package:provider/provider.dart';

class AttendedPage extends StatelessWidget {
  const AttendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<AttendencePageState>();

    if (appState.attended.isEmpty) {
      return Center(
        child:
            Text('No attendence yet.', style: theme.textTheme.headlineMedium),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.attended.length} out of ${appState.studentList.length} students present:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var student in appState.attended)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    // color: Theme.of(context).colorScheme.surface,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundImage: student.imageUrl == null
                            ? AssetImage('assets/bg/favicon.png')
                            : NetworkImage(student.imageUrl!),
                      ),
                      title: Text(
                        '${student.classRoll} - ${student.fullName}',
                      ),
                      subtitle: Text("Reg: ${student.registration}"),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                        color: theme.colorScheme.primary,
                        onPressed: () {
                          appState.removeAttendence(student);
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
