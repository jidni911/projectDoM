import 'package:project_dom/models/users.dart';

class Notice {
  int? id;
  String title;
  String description;
  String date;
  NoticeType noticeType;
  User notifier;
  String? imageUrl;

  Notice(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.noticeType,
      required this.notifier,
      this.imageUrl});

  @override
  String toString() {
    return 'Notice(id: $id, title: $title, description: $description, date: $date, imageUrl: $imageUrl, noticeType: $noticeType, notifier: $notifier)';
  }
}

enum NoticeType {
  official,
  club,
  cr,
  personal;

  @override
  String toString() {
    return name;
  }
}
