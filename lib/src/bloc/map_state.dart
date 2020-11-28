part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;
  final bool followLocation;
  final LatLng centralLocation;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState(
      {this.readyMap = false,
      this.drawRoute = false,
      this.followLocation = false,
      this.centralLocation,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  MapState copyWith(
          {bool readyMap,
          bool drawRoute,
          bool followLocation,
          LatLng centralLocation,
          Map<String, Polyline> polylines}) =>
      MapState(
          readyMap: readyMap ?? this.readyMap,
          drawRoute: drawRoute ?? this.drawRoute,
          followLocation: followLocation ?? this.followLocation,
          centralLocation: centralLocation ?? this.centralLocation,
          polylines: polylines ?? this.polylines);
}
