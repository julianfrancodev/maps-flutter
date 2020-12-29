import 'package:flutter/material.dart';

class MarkerDestiny extends CustomPainter {
  final String description;
  final double meters;

  MarkerDestiny(this.description, this.meters);

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
    path.moveTo(0, 20);

    path.lineTo(size.width - 10, 20);

    path.lineTo(size.width - 10, 100);

    path.lineTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // draw box

    final whiteBox = Rect.fromLTWH(0, 20, size.width - 10, 80);

    canvas.drawRect(whiteBox, paint);

    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(0, 20, 70, 80);

    canvas.drawRect(blackBox, paint);

    // draw texts
    double kilometers = this.meters / 1000;
    kilometers = (kilometers * 100).floor().toDouble();

    TextSpan textSpan = new TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
        text: "${kilometers}");

    TextPainter textPainter = new TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 80, minWidth: 80);

    textPainter.paint(canvas, Offset(0, 35));

    // minutes

    TextSpan textSpanMin = new TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: "Km");

    textPainter = new TextPainter(
        text: textSpanMin,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70);

    textPainter.paint(canvas, Offset(24, 67));

    // My location

    textSpan = new TextSpan(
        style: TextStyle(
            color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w400),
        text: this.description);

    textPainter = new TextPainter(
        ellipsis: "...",
        maxLines: 2,
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left)
      ..layout(maxWidth: size.width - 100);

    textPainter.paint(canvas, Offset(90, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
