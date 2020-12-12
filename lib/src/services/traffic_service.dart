import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/models/driving_response.dart';
import 'package:mapbox_flutter/src/models/search_response.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final Dio _dio = new Dio();
  final String baseUrlDir = "https://api.mapbox.com/directions/v5";
  final String baseUrlGeo = "https://api.mapbox.com/geocoding/v5";
  final String apiKey =
      "pk.eyJ1IjoianVsaWFuZnJhbmNvYWx2YXJhZG8iLCJhIjoiY2tmNzlrbWU3MDA5dTMxbXY5YXBnN2Z3NiJ9.of6WhCbnukPIEsLcxHUElw";

  Future<DrivingResponse> getCoordsStartDestination(LatLng start, LatLng end) async {
    print(start);
    print(end);
    final String coordString =
        "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final String url = "${baseUrlDir}/mapbox/driving/${coordString}";

    final resp = await this._dio.get(url, queryParameters: {
      "alternatives": "true",
      "geometries": "polyline6",
      "steps": "false",
      "access_token": "${this.apiKey}",
      "language": "es",
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }


  Future<SearchResponse> getResultsByQuery(String search, LatLng proximity)async{
    final String url = "${this.baseUrlGeo}/mapbox.places/${search}.json";

    final resp = await this._dio.get(url, queryParameters: {
      "acess_token":this.apiKey,
      "autocomplete":"true",
      "proximity":"${proximity.latitude},${proximity.longitude}",
      "language": "es",
    });

    final searchResponse = searchResponseFromJson(resp.data);


    return searchResponse;

  }

}
