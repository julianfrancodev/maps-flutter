import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/helpers/debouncer.dart';
import 'package:mapbox_flutter/src/models/driving_response.dart';
import 'package:mapbox_flutter/src/models/reverse_query_response.dart';
import 'package:mapbox_flutter/src/models/search_response.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final Dio _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));
  final StreamController<SearchResponse> _suggestionsStreamController =
      new StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get suggestionsStream =>
      this._suggestionsStreamController.stream;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  final String baseUrlDir = "https://api.mapbox.com/directions/v5";
  final String baseUrlGeo = "https://api.mapbox.com/geocoding/v5";
  final String apiKey =
      "pk.eyJ1IjoianVsaWFuZnJhbmNvYWx2YXJhZG8iLCJhIjoiY2tpbWtqd3piMDFqODJxczBtdWx1cXkyOCJ9.Gycz5CVzBdt9--ZytER5dg";

  Future<DrivingResponse> getCoordsStartDestination(
      LatLng start, LatLng end) async {
    print(start);
    print(end);
    final String coordString =
        "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final String url = "${baseUrlDir}/mapbox/driving/$coordString";

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

  Future<SearchResponse> getResultsByQuery(
      String search, LatLng proximity) async {
    final String url = "${this.baseUrlGeo}/mapbox.places/$search.json";
    print("searching");
    try {
      final resp = await this._dio.get(url, queryParameters: {
        "access_token": "${this.apiKey}",
        "autocomplete": "true",
        "proximity": "${proximity.longitude},${proximity.latitude}",
        "language": "es",
      });

      final searchResponse = searchResponseFromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSuggestionsByQuery(String search, LatLng proximity) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final resultados = await this.getResultsByQuery(value, proximity);
      this._suggestionsStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = search;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseQueryResponse> getCoordsInfo(LatLng destinyCoords) async {
    final String url =
        "${this.baseUrlGeo}/mapbox.places/${destinyCoords.longitude},${destinyCoords.latitude}.json";

    final resp = await this._dio.get(url, queryParameters: {
      "access_token": "${this.apiKey}",
      "language": "es",
    });

    final data = reverseQueryResponseFromJson(resp.data);

    return data;

  }

  void closeStream() {
    _suggestionsStreamController.close();
  }
}
