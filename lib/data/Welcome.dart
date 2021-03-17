import 'package:flutter/material.dart';
import 'package:voyage/data/menu_frame.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuFrame(),
    );
  }
}