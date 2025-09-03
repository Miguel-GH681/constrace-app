import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  int projectId;
  String projectName;

  Project({
    required this.projectId,
    required this.projectName,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    projectId: json["project_id"],
    projectName: json["project_name"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "project_name": projectName,
  };
}
