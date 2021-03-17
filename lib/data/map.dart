import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/src/blocs/application_bloc.dart';
import 'package:voyage/src/screens/home_screen.dart';
import 'package:provider/provider.dart';


class Map extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
