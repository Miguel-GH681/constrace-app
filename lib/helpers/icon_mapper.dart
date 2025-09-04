import 'package:flutter/material.dart';

class IconMapper {
  static const Map<String, dynamic> icons = {
    'house_sharp': Icons.house_sharp,
    'chair_sharp': Icons.chair_sharp,
    'emoji_food_beverage_sharp': Icons.emoji_food_beverage_sharp,
    'lightbulb_sharp': Icons.lightbulb_sharp,
    'cloud_sharp': Icons.cloud_sharp
  };

  static IconData getIcon(String name){
    return icons[name] ?? Icons.help_sharp;
  }
}