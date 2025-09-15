import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  int statusId;
  String name;
  dynamic description;

  Status({
    required this.statusId,
    required this.name,
    required this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    statusId: json["status_id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "status_id": statusId,
    "name": name,
    "description": description,
  };
}
