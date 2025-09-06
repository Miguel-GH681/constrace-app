import 'dart:ui';

import 'package:chat_app/theme/app_colors.dart';

class StateMapper{
  static const Map<String, dynamic> states ={
    '4': AppColors.warning,
    '2': AppColors.success,
    '3': AppColors.danger,
    '1': AppColors.darkBackgroundColor,
  };

  static Color getColor(String status_id){
    return states[status_id] ?? AppColors.tertiary;
  }
}