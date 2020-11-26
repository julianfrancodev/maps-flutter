import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/themes/map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(new MapState());
  GoogleMapController _mapController;

  Polyline _myRoute = new Polyline(
      polylineId: PolylineId("my_route"), width: 4, color: Colors.black87);

  void initMap(GoogleMapController googleMapController) {
    if (!state.readyMap) {
      this._mapController = googleMapController;
      this._mapController.setMapStyle(jsonEncode(mapTheme));
      // todo change style map

      add(OnMapLoaded());
    }
  }

  void moveCamera(LatLng destination) {
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnMapLoaded) {
      print("MAP READY");

      yield state.copyWith(readyMap: true);
    } else if (event is OnLocationUpdate) {
      yield* this._onLocationUpdate(event);
    } else if (event is OnDrawRoute) {
      yield* this._onDrawRoute(event);
    }
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async* {
    final List<LatLng> points = [...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onDrawRoute(OnDrawRoute event) async* {
    if (!state.drawRoute) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(
        polylines: currentPolylines, drawRoute: !state.drawRoute);
  }
}
