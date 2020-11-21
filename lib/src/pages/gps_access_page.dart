import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccessPage extends StatefulWidget {
  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage>
    with WidgetsBindingObserver {
  bool popup = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && !popup) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, '/loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es Necesario activar el gps'),
            MaterialButton(
              onPressed: () async {
                // verificar permisos
                popup = true;
                final status = await Permission.location.request();
                await this.gpsAccess(status);
                popup = false;
                print(status);
              },
              child: Text(
                'Solicitar Acesso',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Future gpsAccess(PermissionStatus permissionStatus) async {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, '/map');
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.restricted:
        // TODO: Handle this case.
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      case PermissionStatus.undetermined:
        // TODO: Handle this case.
        break;
    }
  }
}
