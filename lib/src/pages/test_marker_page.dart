import 'package:flutter/material.dart';
import 'package:mapbox_flutter/src/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: 350,
        height: 150,
        color: Colors.red,
        child: CustomPaint(
          painter: MarkerStart(22),
          // painter: MarkerDestiny("Mi casa esta ubicada aqui en algun lugar", 255),
        ),
      )),
    );
  }
}
