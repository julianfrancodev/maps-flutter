import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResutl {
  final bool cancel;
  final bool manual;
  final LatLng position;
  final String destiny;
  final String description;

  SearchResutl(
      {@required this.cancel,
      this.manual,
      this.position,
      this.destiny,
      this.description});
}
