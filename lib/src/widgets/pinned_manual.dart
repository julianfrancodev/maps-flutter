part of "widgets.dart";

class PinnedManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return _BuildManualPin();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildManualPin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        // back button
        Positioned(
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  context.bloc<SearchBloc>().add(OnDisablePinManual());
                },
              ),
            ),
          ),
          top: 70,
          left: 20,
        ),
        Center(
          child: Transform.translate(
              offset: Offset(0, -12),
              child: BounceInDown(
                from: 200,
                child: Icon(
                  Icons.location_on,
                  size: 40,
                ),
              )),
        ),
        // button to confirm destiny

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              child: Text(
                "Confirmar Destino",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              minWidth: width - 120,
              onPressed: () {
                // todo confirm destination
                this.calcDestination(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void calcDestination(BuildContext context) async {

    calcAlert(context);

    final TrafficService trafficService = new TrafficService();
    final mapBloc = context.bloc<MapBloc>();
    final start = context.bloc<MyLocationBloc>().state.location;
    final end = mapBloc.state.centralLocation;

    final trafficResponse =
        await trafficService.getCoordsStartDestination(start, end);

    // decode points from geometry
    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;
    final List<LatLng> routeCords =
        points.map((point) => LatLng(point[0], point[1])).toList();


    mapBloc.add(OnCreateRouteStartDestiny(routeCords, distance, duration));

    Navigator.of(context).pop();

    // todo remove pin and back button

    context.read<SearchBloc>().add(OnDisablePinManual());

  }
}
