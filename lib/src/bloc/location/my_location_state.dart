part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool following;
  final bool validateLocation;
  final LatLng location;

  MyLocationState(
      {this.following = true, this.validateLocation = false, this.location});

  MyLocationState copyWith(
          {bool following, bool validateLocation, LatLng location}) =>
      new MyLocationState(
          following: following ?? this.following,
          validateLocation: validateLocation ?? this.validateLocation,
          location: location ?? this.location);
}
