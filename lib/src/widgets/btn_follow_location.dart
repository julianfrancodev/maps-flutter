part of 'widgets.dart';

class BtnFollowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return _renderButton(state, context);
      },
    );
  }

  Widget _renderButton(MapState state, BuildContext context) {
    final mapBloc = context.bloc<MapBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 24,
        child: IconButton(
          icon: Icon(
            state.followLocation
                ? Icons.directions_run
                : Icons.accessibility_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () {
            mapBloc.add(OnFollowLocation());
          },
        ),
      ),
    );
  }
}
