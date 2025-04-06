import 'package:flutter/material.dart';
import 'package:project_dom/models/notices.dart';
import 'package:project_dom/models/users.dart';

class NoticeFormWidget extends StatefulWidget {
  const NoticeFormWidget({ required this.loadNotices,super.key});

  final Function loadNotices;

  @override
  State<NoticeFormWidget> createState() => _NoticeFormWidgetState();
}

class _NoticeFormWidgetState extends State<NoticeFormWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    NoticeType? noticeType;
    User? notifier;
    String? imageUrl;

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          DropdownButton<NoticeType>(
            value: noticeType,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (NoticeType? newValue) {
              setState(() {
                noticeType = newValue;
              });
            },
            items: NoticeType.values
                .map<DropdownMenuItem<NoticeType>>((NoticeType value) {
              return DropdownMenuItem<NoticeType>(
                value: value,
                child: Text(value.name),
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

        ],
      ),
    );
  }
}