import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_flutter/src/bloc/map/map_bloc.dart';
import 'package:mapbox_flutter/src/bloc/location/my_location_bloc.dart';
import 'package:mapbox_flutter/src/bloc/search/search_bloc.dart';
import 'package:mapbox_flutter/src/pages/test_marker_page.dart';
import 'package:mapbox_flutter/src/routes/routes.dart';

void main(){
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> MyLocationBloc()),
        BlocProvider(create: (_)=> MapBloc(),),
        BlocProvider(create: (_)=>SearchBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gps',
        home: TestMarkerPage(),
        // initialRoute: '/loading',
        // routes: routes,
      ),
    )
  );
}