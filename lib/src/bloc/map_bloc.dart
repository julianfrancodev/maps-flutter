import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(new MapState());
  GoogleMapController _mapController;

  void initMap(GoogleMapController googleMapController){
    if(!state.readyMap){
      this._mapController = googleMapController;

      // todo change style map

      add(OnMapLoaded());
    }
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
