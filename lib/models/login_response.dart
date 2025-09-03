import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  User msg;
  String token;

  LoginResponse({
    required this.ok,
    required this.msg,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    ok: json["ok"],
    msg: User.fromJson(json["msg"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg.toJson(),
    "token": token,
  };
}