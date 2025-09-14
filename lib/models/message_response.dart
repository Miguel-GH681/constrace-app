// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

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
  int messageId;
  int senderId;
  int receiverId;
  String message;
  DateTime sendDate;

  Msg({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sendDate,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    messageId: json["message_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    sendDate: DateTime.parse(json["send_date"]),
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "send_date": "${sendDate.year.toString().padLeft(4, '0')}-${sendDate.month.toString().padLeft(2, '0')}-${sendDate.day.toString().padLeft(2, '0')}",
  };
}
