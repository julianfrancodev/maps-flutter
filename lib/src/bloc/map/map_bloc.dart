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
      polylineId: PolylineId("my_route"), width: 4, color: Colors.transparent);

  Polyline _myRouteDestiny = new Polyline(
      polylineId: PolylineId("my_route_destiny"),
      width: 4,
      color: Colors.black87);

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
    } else if (event is OnFollowLocation) {
      yield* this._onFollowLocation(event);
    } else if (event is OnMoveMap) {
      print(event.centralLocation);
      yield state.copyWith(centralLocation: event.centralLocation);
    } else if (event is OnCreateRouteStartDestiny) {
      yield* _onCreateRouteStartDestiny(event);
    }
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async* {
    if (state.followLocation) {
      this.moveCamera(event.location);
    }

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

  Stream<MapState> _onFollowLocation(OnFollowLocation event) async* {
    print(event);
    if (!state.followLocation) {
      this.moveCamera(this._myRoute.points[this._myRoute.points.length - 1]);
    }
    yield state.copyWith(followLocation: !state.followLocation);
  }

  Stream<MapState> _onCreateRouteStartDestiny(
      OnCreateRouteStartDestiny event) async* {
    this._myRouteDestiny =
        this._myRouteDestiny.copyWith(pointsParam: event.routeCoords);

    final currentPolylines = state.polylines;

    currentPolylines['my_route_destiny'] = this._myRouteDestiny;

    // Markers

    final markerStart = new Marker(
        markerId: MarkerId("start"),
        position: event.routeCoords[0],
        infoWindow: InfoWindow(
            title: "Mi casa",
            snippet: "Punto Inicial",
            anchor: Offset(0.5, 0),
            onTap: () {
              print("info window tap");
            }));

    final markerEnd = new Marker(
        markerId: MarkerId("end"),
        position: event.routeCoords[event.routeCoords.length - 1]);
    final newMarkers = {...state.markers};
    newMarkers["start"] = markerStart;
    newMarkers["end"] = markerEnd;

    yield state.copyWith(polylines: currentPolylines, markers: newMarkers);
  }
}
