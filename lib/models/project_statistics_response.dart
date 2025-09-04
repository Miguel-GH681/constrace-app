import 'dart:convert';

import 'package:chat_app/models/statistics.dart';

ProjectStatisticsResponse projectStatisticsResponseFromJson(String str) => ProjectStatisticsResponse.fromJson(json.decode(str));

String projectStatisticsResponseToJson(ProjectStatisticsResponse data) => json.encode(data.toJson());

class ProjectStatisticsResponse {
  bool ok;
  Statistics msg;

  ProjectStatisticsResponse({
    required this.ok,
    required this.msg,
  });

  factory ProjectStatisticsResponse.fromJson(Map<String, dynamic> json) => ProjectStatisticsResponse(
    ok: json["ok"],
    msg: Statistics.fromJson(json["msg"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg.toJson(),
  };
}
