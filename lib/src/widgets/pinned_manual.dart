part of "widgets.dart";

class PinnedManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state){
        if(state.manualSelection){
          return _BuildManualPin();
        }else{
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

  void calcDestination(BuildContext context)async{
    final TrafficService trafficService = new TrafficService();
    final start = context.bloc<MyLocationBloc>().state.location;
    final end = context.bloc<MapBloc>().state.centralLocation;

    await trafficService.getCoordsStartDestination(start, end);

  }

}
