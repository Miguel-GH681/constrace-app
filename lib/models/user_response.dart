import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool ok;
  List<User> msg;

  UserResponse({
    required this.ok,
    required this.msg,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    ok: json["ok"],
    msg: List<User>.from(json["msg"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}
