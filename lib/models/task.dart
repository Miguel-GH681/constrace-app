import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  int taskId;
  String title;
  String description;
  DateTime initDate;
  int hoursWorked;
  int estimatedHours;
  String status;
  String taskType;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.initDate,
    required this.hoursWorked,
    required this.estimatedHours,
    required this.status,
    required this.taskType,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    taskId: json["task_id"],
    title: json["title"],
    description: json["description"],
    initDate: DateTime.parse(json["init_date"]),
    hoursWorked: json["hours_worked"],
    estimatedHours: json["estimated_hours"],
    status: json["status"],
    taskType: json["task_type"],
  );

  Map<String, dynamic> toJson() => {
    "task_id": taskId,
    "title": title,
    "description": description,
    "init_date": "${initDate.year.toString().padLeft(4, '0')}-${initDate.month.toString().padLeft(2, '0')}-${initDate.day.toString().padLeft(2, '0')}",
    "hours_worked": hoursWorked,
    "estimated_hours": estimatedHours,
    "status": status,
    "task_type": taskType,
  };
}
