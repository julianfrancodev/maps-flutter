import 'package:flutter/material.dart';

class MarkerStart extends CustomPainter {

  final int minutos;

  MarkerStart(this.minutos);

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

    // draw texts

    TextSpan textSpan = new TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        text: "${this.minutos}");

    TextPainter textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, Offset(30, 35));

    // minutes

    TextSpan textSpanMin = new TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: "Min");

     textPainter = new TextPainter(
        text: textSpanMin,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, Offset(30, 67));

    // My location

    textSpan = new TextSpan(
        style: TextStyle(
            color: Colors.black87 , fontSize: 22, fontWeight: FontWeight.w400),
        text: "Mi Ubicacion");

    textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: size.width - 130);

    textPainter.paint(canvas, Offset(150, 50));



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
