import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));

String statisticsToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
  int totalTasks;
  int finishedTasks;

  Statistics({
    required this.totalTasks,
    required this.finishedTasks,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    totalTasks: json["totalTasks"],
    finishedTasks: json["finishedTasks"],
  );

  Map<String, dynamic> toJson() => {
    "totalTasks": totalTasks,
    "finishedTasks": finishedTasks,
  };
}
