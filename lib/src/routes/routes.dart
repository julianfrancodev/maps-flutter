import 'package:flutter/material.dart';
import 'package:mapbox_flutter/src/pages/gps_access_page.dart';
import 'package:mapbox_flutter/src/pages/loading_page.dart';
import 'package:mapbox_flutter/src/pages/map_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
    '/loading':(context) => LoadingPage(),
    '/gps':(context)=> GpsAccessPage(),
    '/map':(context)=> MapPage()
};