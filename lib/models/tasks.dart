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
    required this.taskType,
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
      'done': isDone,
      'dateTime': dateTime.toIso8601String(),
      'taskType': taskType.value,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['done'],
      dateTime: DateTime.parse(map['dateTime']),
      user: User.fromJson(map['user']),
      taskType: TaskTypeExtension.fromValue(map['taskType']),
    );
  }
}

enum TaskType {
  private,
  official,
}

extension TaskTypeExtension on TaskType {
  String get value {
    switch (this) {
      case TaskType.private:
        return "PRIVATE";
      case TaskType.official:
        return "OFFICIAL";
    }
  }

  static TaskType fromValue(String value) {
    switch (value.toUpperCase()) {
      case "PRIVATE":
        return TaskType.private;
      case "OFFICIAL":
        return TaskType.official;
      default:
        throw Exception("Invalid TaskType: $value");
    }
  }
}
