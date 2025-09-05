import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  int projectId;
  String projectName;
  DateTime finalDate;
  String projectOwner;

  Project({
    required this.projectId,
    required this.projectName,
    required this.finalDate,
    required this.projectOwner,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    projectId: json["project_id"],
    projectName: json["project_name"],
    finalDate: DateTime.parse(json["final_date"]),
    projectOwner: json["project_owner"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "project_name": projectName,
    "final_date": "${finalDate.year.toString().padLeft(4, '0')}-${finalDate.month.toString().padLeft(2, '0')}-${finalDate.day.toString().padLeft(2, '0')}",
    "project_owner": projectOwner,
  };
}
