import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
  bool ok;
  List<Msg> msg;

  MessageResponse({
    required this.ok,
    required this.msg,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    ok: json["ok"],
    msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}

class Msg {
  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Msg({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    from: json["from"],
    to: json["to"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
