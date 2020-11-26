part of 'widgets.dart';

class BtnMyRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.bloc<MapBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 24,
        child: IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
          onPressed: () {
            mapBloc.add(OnDrawRoute());
          },
        ),
      ),
    );
  }
}
