import 'package:flutter/material.dart';
import 'package:project_dom/models/assignments.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Assignment> assignments = demoAssignments;
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Assignments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => AssignmentCard(assignments[index]),
            itemCount: assignments.length,
          ),
        ),
      ],
    );
  }
}

class AssignmentCard extends StatelessWidget {
  const AssignmentCard(this.assignment, {super.key});
  final Assignment assignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: CircleAvatar(child: Text('${assignment.id}')),
        textColor: Theme.of(context).colorScheme.onSurface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        // collapsedTextColor: Theme.of(context).colorScheme.onSurface,
        // collapsedIconColor: Theme.of(context).colorScheme.onSurface,
        // iconColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(assignment.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        children: [
          ListTile(
            title: Text('Description'),
            subtitle: Text(assignment.description.join(', ')),
          ),
          ListTile(
            title: Text('Date'),
            subtitle: Text(assignment.date),
          ),
          ListTile(
            title: Text('Due Date'),
            subtitle: Text(assignment.dueDate),
          ),
          ListTile(
            title: Text('Assigned By'),
            subtitle: Text(assignment.assignedBy),
          ),
          ListTile(
            title: Text('Assigned To'),
            subtitle: Text(assignment.assignedTo),
          ),
        ],
      ),
    );
  }
}
