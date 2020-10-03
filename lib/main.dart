import 'package:flutter/material.dart';
import 'package:mapbox_flutter/src/routes/routes.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gps',
      initialRoute: '/loading',
      routes: routes,
    )
  );
}