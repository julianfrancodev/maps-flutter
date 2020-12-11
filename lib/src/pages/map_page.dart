import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/bloc/map/map_bloc.dart';
import 'package:mapbox_flutter/src/bloc/location/my_location_bloc.dart';
import 'package:mapbox_flutter/src/widgets/widgets.dart';

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
      body: Stack(
        children: <Widget>[
          BlocBuilder<MyLocationBloc, MyLocationState>(
            builder: (BuildContext context, state) {
              return renderMap(state);
            },
          ),
          Positioned(top: 20, child: SearchBarWidget()),
          PinnedManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BtnLocation(),
          BtnFollowLocation(),
          BtnMyRoute(),
        ],
      ),
    );
  }

  Widget renderMap(MyLocationState myLocationState) {
    if (!myLocationState.validateLocation) return Text('Location...');
    final mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add(OnLocationUpdate(myLocationState.location));

    final CameraPosition cameraPosition =
        new CameraPosition(target: myLocationState.location, zoom: 15);

    return BlocBuilder<MapBloc, MapState>(builder: (context, _) {
      return GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: mapBloc.initMap,
        polylines: mapBloc.state.polylines.values.toSet(),
        onCameraMove: (cameraPosition) {
          mapBloc.add(OnMoveMap(cameraPosition.target));
        },
        onCameraIdle: () {
          print("MapIdle");
        },
      );
    });
  }
}
