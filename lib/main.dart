import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_flutter/src/bloc/map_bloc.dart';
import 'package:mapbox_flutter/src/bloc/my_location_bloc.dart';
import 'package:mapbox_flutter/src/routes/routes.dart';

void main(){
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> MyLocationBloc()),
        BlocProvider(create: (_)=> MapBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gps',
        initialRoute: '/loading',
        routes: routes,
      ),
    )
  );
}