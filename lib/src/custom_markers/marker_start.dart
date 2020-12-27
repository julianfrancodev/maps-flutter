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
    // Shadow
    final Path path = new Path();
    path.moveTo(40, 20);

    path.lineTo(size.width - 10, 20);

    path.lineTo(size.width - 10, 100);

    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // draw box

    final whiteBox = Rect.fromLTWH(40, 20, size.width - 55, 80);

    canvas.drawRect(whiteBox, paint);

    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(30, 20, 70, 80);

    canvas.drawRect(blackBox, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
