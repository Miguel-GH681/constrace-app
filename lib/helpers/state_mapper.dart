import 'dart:ui';

import 'package:chat_app/theme/app_colors.dart';

class StateMapper{
  static const Map<String, dynamic> states ={
    '1': AppColors.warning,
    '2': AppColors.success,
    '3': AppColors.danger,
    '4': AppColors.text70,
  };

  static Color getColor(String status_id){
    return states[status_id] ?? AppColors.tertiary;
  }
}