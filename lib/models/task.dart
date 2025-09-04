import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String title;
  String description;
  DateTime initDate;
  String status;
  String taskType;

  Task({
    required this.title,
    required this.description,
    required this.initDate,
    required this.status,
    required this.taskType,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"],
    description: json["description"],
    initDate: DateTime.parse(json["init_date"]),
    status: json["status"],
    taskType: json["task_type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "init_date": "${initDate.year.toString().padLeft(4, '0')}-${initDate.month.toString().padLeft(2, '0')}-${initDate.day.toString().padLeft(2, '0')}",
    "status": status,
    "task_type": taskType,
  };
}
