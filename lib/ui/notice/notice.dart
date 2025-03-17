import 'package:flutter/material.dart';
import 'package:project_dom/models/notices.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Notice> notices = [
      Notice(
          id: 1,
          title: 'Notice 1',
          description: 'Description 1',
          date: '2023-09-01',
          imageUrl: ''),
      Notice(
          id: 2,
          title: 'Notice 2',
          description: 'Description 2',
          date: '2023-09-02',
          imageUrl: ''),
      Notice(
          id: 3,
          title: 'Notice 3',
          description: 'Description 3',
          date: '2023-09-03',
          imageUrl: ''),
    ];
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.surface,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(''),
          ),
        ),
      ),
      Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              width: 200,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notice Board',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          for (var notice in notices) NoticeWidget(notice: notice),
        ],
      ),
    ]);
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key, required this.notice});
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
        child: ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(
              notice.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
                letterSpacing: 2,
              ),
            ),
            subtitle: Text(
              notice.description,
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
            )),
      ),
    );
  }
}
