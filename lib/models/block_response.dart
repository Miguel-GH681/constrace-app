import 'dart:convert';

import 'package:chat_app/models/block.dart';

BlockResponse blockResponseFromJson(String str) => BlockResponse.fromJson(json.decode(str));

String blockResponseToJson(BlockResponse data) => json.encode(data.toJson());

class BlockResponse {
  bool ok;
  List<Block> msg;

  BlockResponse({
    required this.ok,
    required this.msg,
  });

  factory BlockResponse.fromJson(Map<String, dynamic> json) => BlockResponse(
    ok: json["ok"],
    msg: List<Block>.from(json["msg"].map((x) => Block.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}
