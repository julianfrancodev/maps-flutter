import 'package:flutter/material.dart';
import 'package:mapbox_flutter/src/helpers/helpers.dart';
import 'package:mapbox_flutter/src/pages/gps_access_page.dart';
import 'package:mapbox_flutter/src/pages/map_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsLocation(context),
        builder: (context, snapshot){
          return  Center(
            child: CircularProgressIndicator(strokeWidth: 2,),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async{
    // TODO permiso gps
    // TODO enable gps
    await Future.delayed(Duration(milliseconds: 100));
    Navigator.pushReplacement(context, navigateFadeIn(context, GpsAccessPage()));
    // Navigator.pushReplacement(context, navigateFadeIn(context, MapPage()));

  }
}
