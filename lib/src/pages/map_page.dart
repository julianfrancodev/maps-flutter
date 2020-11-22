import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/bloc/my_location_bloc.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    // TODO: implement initState

    context.bloc<MyLocationBloc>().startFollowing();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    context.bloc<MyLocationBloc>().disposeFollowing();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (BuildContext context, state) {
          return renderMap(state);
        },
      ),
    );
  }

  Widget renderMap(MyLocationState myLocationState) {
    if (!myLocationState.validateLocation) return Text('Location...');
    final CameraPosition cameraPosition =
        new CameraPosition(target: myLocationState.location, zoom: 15);
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}
