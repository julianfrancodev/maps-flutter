part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;
  final bool followLocation;

  // Polylines

  final Map<String, Polyline> polylines;

  MapState(
      {this.readyMap = false,
      this.drawRoute = true,
      this.followLocation = false,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  MapState copyWith(
          {bool readyMap,
          bool drawRoute,
          bool followLocation,
          Map<String, Polyline> polylines}) =>
      MapState(
          readyMap: readyMap ?? this.readyMap,
          drawRoute: drawRoute ?? this.drawRoute,
          followLocation: followLocation ?? this.followLocation,
          polylines: polylines ?? this.polylines);
}
