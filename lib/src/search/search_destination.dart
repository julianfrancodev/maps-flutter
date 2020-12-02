

import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate{

  @override
  final String searchFieldLabel;

  SearchDestination() : this.searchFieldLabel = "Buscar...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=> this.query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    //todo return something

    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Text("Build Results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
      ListTile(
        leading: Icon(Icons.location_on_outlined),
        title: Text("Colocar Ubication Manualmente"),
        onTap: (){

          // todo return something

          print("Manualmente");
          this.close(context, null);
        },
      )
      ],
    );
  }
  
}
