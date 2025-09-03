import 'dart:convert';

import 'package:chat_app/models/project.dart';

ProjectResponse projectResponseFromJson(String str) => ProjectResponse.fromJson(json.decode(str));

String projectResponseToJson(ProjectResponse data) => json.encode(data.toJson());

class ProjectResponse {
  bool ok;
  List<Project> msg;

  ProjectResponse({
    required this.ok,
    required this.msg,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) => ProjectResponse(
    ok: json["ok"],
    msg: List<Project>.from(json["msg"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}
