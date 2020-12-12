import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/models/search_result.dart';
import 'package:mapbox_flutter/src/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResutl> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;

  SearchDestination(this.proximity)
      : this.searchFieldLabel = "Buscar...",
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //todo return something

    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResutl(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    this._trafficService.getResultsByQuery(this.query.trim(), this.proximity);
    return Text("Build Results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on_outlined),
          title: Text("Colocar Ubication Manualmente"),
          onTap: () {
            // todo return something

            print("Manualmente");
            this.close(context, SearchResutl(cancel: false, manual: true));
          },
        )
      ],
    );
  }
}
