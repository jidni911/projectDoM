import 'package:project_dom/models/users.dart';

class Task {
  int? id;
  String title;
  String description;
  bool isDone;
  DateTime dateTime;

  User? user;

  TaskType taskType;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.dateTime,
    this.user,
    this.taskType = TaskType.private,
  });

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, isDone: $isDone, dateTime: $dateTime)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'dateTime': dateTime.toIso8601String(),
      'taskType': taskType.name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      dateTime: DateTime.parse(map['dateTime']),
      user: User.fromJson(map['user']),
    );
  }
}

enum TaskType {
  private,
  official,
}
