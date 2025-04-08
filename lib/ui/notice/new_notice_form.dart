import 'package:flutter/material.dart';
import 'package:project_dom/models/notices.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/service/notice_service.dart';

class NoticeFormWidget extends StatefulWidget {
  const NoticeFormWidget({required this.loadNotices, super.key});

  final Function loadNotices;

  @override
  State<NoticeFormWidget> createState() => _NoticeFormWidgetState();
}

class _NoticeFormWidgetState extends State<NoticeFormWidget> {
    NoticeService noticeService = NoticeService();
  
    late TextEditingController titleController ;
    late TextEditingController descriptionController ;
    late TextEditingController dateController;
  
    NoticeType? noticeType = NoticeType.official;
    User? notifier;
    String? imageUrl;


  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    loadUser();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  loadUser() async {
    User? user = await AuthService().getProfileLocal();
    setState(() {
      notifier = user;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  dateController.text = date.toString();
                }
              },
            ),
            Text('Notice Type : $noticeType'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: NoticeType.values.map<Widget>((NoticeType value) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<NoticeType>(
                      value: value,
                      groupValue: noticeType,
                      onChanged: (NoticeType? newValue) {
                        setState(() {
                          noticeType = newValue;
                        });
                      },
                    ),
                    Text(value
                        .toString()
                        .split('.')
                        .last),
                  ],
                );
              }).toList(),
            ),

            TextField(
              decoration: InputDecoration(labelText: 'Notifier\'s id'),
              onChanged: (value) {
                notifier = User(id: int.parse(value), fullName: '', email: '');
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                imageUrl = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                Notice notice = Notice(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  noticeType: noticeType!,
                  notifier: notifier!,
                  imageUrl: imageUrl,
                );
                 Notice? newNotice = await noticeService.createNotice(notice);
                if (newNotice != null) {
                  titleController.clear();
                  descriptionController.clear();
                  dateController.clear();
                  notifier = null;
                  imageUrl = null;
                } else {
                  print('Failed to create notice');
                }
                widget.loadNotices();
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
