part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent{}

class OnDrawRoute extends MapEvent{}

class OnLocationUpdate extends MapEvent{
  final LatLng location;

  OnLocationUpdate(this.location);

}
