import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  int userId;
  String projectName;
  String fullName;
  String description;

  Contact({
    required this.userId,
    required this.projectName,
    required this.fullName,
    required this.description,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    userId: json["user_id"],
    projectName: json["project_name"],
    fullName: json["full_name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "project_name": projectName,
    "full_name": fullName,
    "description": description,
  };
}
