import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:mapbox_flutter/src/helpers/helpers.dart';
import 'package:mapbox_flutter/src/pages/gps_access_page.dart';
import 'package:mapbox_flutter/src/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if(state == AppLifecycleState.resumed){
      if(await Geolocator.isLocationServiceEnabled()){
        Navigator.pushReplacement(context, navigateFadeIn(context, MapPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsLocation(context),
        builder: (context, snapshot){
        if(snapshot.hasData){
          return Center(child: Text(snapshot.data),);
        }
        return CircularProgressIndicator();
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async{
    // TODO permiso gps
    final gpsPermission = await Permission.location.isGranted;
    // TODO enable gps
    final gpsEnabled = await Geolocator.isLocationServiceEnabled();

    if(gpsPermission && gpsEnabled){
      Navigator.pushReplacement(context, navigateFadeIn(context, MapPage()));
      return '';
    }else if(!gpsPermission){
      Navigator.pushReplacement(context, navigateFadeIn(context, GpsAccessPage()));
      return 'Activa el gps';
    }else {
      return 'Necesitas activar el gps';
    }


  }
}
