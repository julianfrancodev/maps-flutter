part of "widgets.dart";

class PinnedManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        // back button
        Positioned(
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                // todo do something
              },
            ),
          ),
          top: 70,
          left: 20,
        ),
        Center(
          child: Transform.translate(
              offset: Offset(0, -12),
              child: Icon(
                Icons.location_on,
                size: 40,
              )),
        ),
        // button to confirm destiny

        Positioned(
          bottom: 70,
          left: 40,
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
            },
          ),
        )
      ],
    );
  }
}
