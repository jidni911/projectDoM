
import 'package:flutter/material.dart';
import 'package:project_dom/models/notices.dart';

class NoticeItemWidget extends StatelessWidget {
  const NoticeItemWidget({super.key, required this.notice});
  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          leading: Icon(
            Icons.info,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notice.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 2,
                ),
              ),
              Text(
                " - ${notice.notifier.fullName}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          subtitle: Text(
            "${notice.noticeType} - ${notice.description}",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onPrimary,
              letterSpacing: 2,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notice.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 2,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notice.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notice.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notice.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                notice.imageUrl!,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
