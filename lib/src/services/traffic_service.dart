import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/models/driving_response.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final Dio _dio = new Dio();
  final String baseUrl = "https://api.mapbox.com/directions/v5";
  final String apiKey =
      "pk.eyJ1IjoianVsaWFuZnJhbmNvYWx2YXJhZG8iLCJhIjoiY2tmNzlrbWU3MDA5dTMxbXY5YXBnN2Z3NiJ9.of6WhCbnukPIEsLcxHUElw";

  Future<DrivingResponse> getCoordsStartDestination(LatLng start, LatLng end) async {
    print(start);
    print(end);
    final String coordString =
        "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final String url = "${baseUrl}/mapbox/driving/${coordString}";

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
}
