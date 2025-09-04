import 'dart:convert';

Block blockFromJson(String str) => Block.fromJson(json.decode(str));

String blockToJson(Block data) => json.encode(data.toJson());

class Block {
  int blockId;
  String name;
  String icon;
  int totalTasks;
  int finishedTasks;

  Block({
    required this.blockId,
    required this.name,
    required this.icon,
    required this.totalTasks,
    required this.finishedTasks,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    blockId: json["block_id"],
    name: json["name"],
    icon: json["icon"],
    totalTasks: json["total_tasks"],
    finishedTasks: json["finished_tasks"],
  );

  Map<String, dynamic> toJson() => {
    "block_id": blockId,
    "name": name,
    "icon": icon,
    "total_tasks": totalTasks,
    "finished_tasks": finishedTasks,
  };
}
