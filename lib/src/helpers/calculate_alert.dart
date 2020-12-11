part of 'helpers.dart';

void calcAlert(BuildContext context) {
  if (!Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Espere Porfavor'),
              content: Text("Calculando Ruta..."),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Espere Porfavor"),
              content: CupertinoActivityIndicator(),
            ));
  }
}
