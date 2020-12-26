import 'package:flutter/material.dart';

class MarkerStart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double circleRadius = 20;
    final double circleRadiusWhite = 20;


    Paint paint = new Paint()..color = Colors.black87;

    // Draw black cricle

    canvas.drawCircle(
        Offset(circleRadius, size.height - circleRadius), 20, paint);

    // White Circle

    paint.color = Colors.white;

    canvas.drawCircle(
        Offset(circleRadiusWhite, size.height - circleRadiusWhite), 7, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
