// To parse this JSON data, do
//
//     final statusResponse = statusResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/status.dart';

StatusResponse statusResponseFromJson(String str) => StatusResponse.fromJson(json.decode(str));

String statusResponseToJson(StatusResponse data) => json.encode(data.toJson());

class StatusResponse {
  bool ok;
  List<Status> msg;

  StatusResponse({
    required this.ok,
    required this.msg,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
    ok: json["ok"],
    msg: List<Status>.from(json["msg"].map((x) => Status.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}
