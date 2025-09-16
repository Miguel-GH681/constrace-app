import 'dart:ui';

import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CardCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.24, size.height * 0.30,
        size.width * 0.49, size.height * 0.30);
    path.quadraticBezierTo(
        size.width * 0.73, size.height * 0.30, size.width, size.height * 0.20);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}