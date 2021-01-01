part of "helpers.dart";

Future<BitmapDescriptor> getMarkerStartIcon(int seconds) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);

  final minutes = (seconds / 60).floor();

  final markerStart = new MarkerStart(minutes);

  markerStart.paint(canvas, size);

  final Picture picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}


Future<BitmapDescriptor> getMarkerDestinyIcon(double meters, String description) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(350, 150);


  final markerDestiny = new MarkerDestiny(description,meters);

  markerDestiny.paint(canvas, size);

  final Picture picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}
