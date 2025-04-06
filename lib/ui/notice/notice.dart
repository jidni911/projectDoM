import 'package:flutter/material.dart';
import 'package:project_dom/models/notices.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/service/notice_service.dart';
import 'package:project_dom/ui/notice/new_notice_form.dart';
import 'package:project_dom/ui/notice/notice_item_widget.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  NoticeService noticeService = NoticeService();
  User? user;
  List<Notice> notices = [];
  @override
  void initState() {
    super.initState();
    refreshUser();
    loadNotices();
  }

  loadNotices() async {
    List<Notice> notices = await noticeService.getNotices();
    setState(() {
      this.notices = notices;
    });
  }

  refreshUser() async {
    User? user = await AuthService().getProfileLocal();
    setState(() {
      this.user = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.surface,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'https://easanfineart.com/wp-content/uploads/2023/11/Art-2-600x600.jpg'),
          ),
        ),
      ),
      SingleChildScrollView(
        child: Column(
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome, ${user?.fullName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                    letterSpacing: 2,
                  )),
              ),
            ),
            if(user!=null) ElevatedButton.icon(
              onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: NoticeFormWidget(
                      loadNotices: loadNotices,
                    ),
                  );
                });
            
              },
              label: Text('Add Notice'),
              icon: Icon(Icons.add),
            ),
            SizedBox(height: 10),
            for (var notice in notices) NoticeItemWidget(notice: notice),
          ],
        ),
      ),
    ]);
  }
}
