import 'dart:convert';

import 'package:chat_app/models/task.dart';

TaskResponse taskResponseFromJson(String str) => TaskResponse.fromJson(json.decode(str));

String taskResponseToJson(TaskResponse data) => json.encode(data.toJson());

class TaskResponse {
  bool ok;
  List<Task> msg;

  TaskResponse({
    required this.ok,
    required this.msg,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
    ok: json["ok"],
    msg: List<Task>.from(json["msg"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}
