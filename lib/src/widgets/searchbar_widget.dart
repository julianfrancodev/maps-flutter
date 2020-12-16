part of 'widgets.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return Container();
        } else {
          return FadeInDown(
              duration: Duration(milliseconds: 300),
              child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximity = context
                .bloc<MyLocationBloc>()
                .state
                .location;
            print("Searching");
            final SearchResutl result = await showSearch(
                context: context, delegate: SearchDestination(proximity));
            this.returnSearch(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text(
              "Donde quieres ir?",
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }

  void returnSearch(BuildContext context, SearchResutl resutl) async {
    print(resutl.cancel);
    print(resutl.manual);
    if (resutl.cancel) return;

    if (resutl.manual) {
      context.bloc<SearchBloc>().add(OnEnablePinManual());
      return;
    }

    //calculate route from Result value

    final TrafficService trafficService = new TrafficService();

    final mapBloc = context.bloc<MapBloc>();

    final start = context
        .bloc<MyLocationBloc>()
        .state
        .location;

    final destiny = resutl.position;

    final drivingResponse =
    await trafficService.getCoordsStartDestination(start, destiny);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    final List<LatLng> routeCoords = points.decodedCoords.map((point) =>
        LatLng(point[0], point[1])).toList();

    mapBloc.add(OnCreateRouteStartDestiny(routeCoords, distance, duration));

    Navigator.of(context).pop();
  }
}
