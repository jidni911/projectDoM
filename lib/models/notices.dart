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

  static Notice fromJson(json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      noticeType: NoticeType.values[json['noticeType']],
      notifier: User.fromJson(json['notifier']),
      imageUrl: json['imageUrl'],
    );
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
