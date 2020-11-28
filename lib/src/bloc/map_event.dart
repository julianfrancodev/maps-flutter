part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapLoaded extends MapEvent{}

class OnDrawRoute extends MapEvent{}

class OnFollowLocation extends MapEvent{}

class OnMoveMap extends MapEvent{
  final LatLng centralLocation;

  OnMoveMap(this.centralLocation);
}

class OnLocationUpdate extends MapEvent{
  final LatLng location;

  OnLocationUpdate(this.location);

}
