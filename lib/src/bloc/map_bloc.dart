import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/themes/map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(new MapState());
  GoogleMapController _mapController;

  void initMap(GoogleMapController googleMapController){
    if(!state.readyMap){
      this._mapController = googleMapController;
      this._mapController.setMapStyle(jsonEncode(mapTheme));
      // todo change style map

      add(OnMapLoaded());
    }
  }

  void moveCamera(LatLng destination){
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {

    if(event is OnMapLoaded){
      print("MAP READY");
      yield state.copyWith(readyMap: true);
    }

  }
}
