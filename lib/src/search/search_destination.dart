import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_flutter/src/models/search_response.dart';
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
    return this._buildSuggestionsResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
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

    return this._buildSuggestionsResult();
  }

  Widget _buildSuggestionsResult() {
    if (this.query.length == 0) {
      return Container();
    }
    this
        ._trafficService
        .getSuggestionsByQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      stream: this._trafficService.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          print(snapshot);
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final places = snapshot.data.features;

        if (places.length == 0) {
          return ListTile(
            title: Text("No hay resultados para $query"),
          );
        }

        return ListView.separated(
          itemBuilder: (_, index) {
            final place = places[index];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(place.textEs),
              subtitle: Text(place.placeNameEs),
              onTap: () {
                print(place);
                this.close(
                    context,
                    SearchResutl(
                        cancel: false,
                        manual: false,
                        position: LatLng(place.center[1], place.center[0]),
                        destiny: place.textEs,
                        description: place.placeNameEs));
              },
            );
          },
          separatorBuilder: (_, i) => Divider(),
          itemCount: places.length,
        );
      },
    );
  }
}
