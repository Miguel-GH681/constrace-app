import 'package:flutter/material.dart';

class IconMapper {
  static const Map<String, dynamic> icons = {
    'house_sharp': Icons.house_sharp,
    'chair_sharp': Icons.chair_sharp,
    'emoji_food_beverage_sharp': Icons.emoji_food_beverage_sharp,
    'local_florist_sharp': Icons.local_florist_sharp,
    'lightbulb_sharp': Icons.lightbulb_sharp,
    'cloud_sharp': Icons.cloud_sharp,
    'terrain_sharp': Icons.terrain_sharp,
    'water_drop_sharp': Icons.water_drop_sharp,
  };

  static IconData getIcon(String name){
    return icons[name] ?? Icons.help_sharp;
  }
}