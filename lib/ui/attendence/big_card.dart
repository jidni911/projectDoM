import 'package:flutter/material.dart';
import 'package:project_dom/models/students.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Roll: ${student.classRoll}",
                    style: style.copyWith(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Name: ${student.fullName}",
                    style: style.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Reg: ${student.registration}",
                    style: style.copyWith(fontSize: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: student.imageUrl == null
                        ? AssetImage('assets/bg/favicon.png')
                        : NetworkImage(student.imageUrl!),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Section: ${student.section}",
                    style: style.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Year: ${student.getYear()}",
                    style: style.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Session: ${student.session}",
                    style: style.copyWith(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
