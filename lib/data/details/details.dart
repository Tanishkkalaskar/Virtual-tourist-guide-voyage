import 'package:flutter/material.dart';
import 'package:voyage/data/products.dart';
import 'package:voyage/data/homescreen.dart';
import 'body_details.dart';
import 'package:voyage/data/Feedback.dart';

class DetailsScreen extends StatelessWidget {
  final Landmark landm;
  const DetailsScreen({Key key, this.landm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: landm.color,
        appBar: buildAppBar(context),
        body: Body(landm: landm));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: landm.color,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              )),
      actions: [
        IconButton(
          icon: Icon(
            Icons.feedback,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => feedback(landm: landm)),
            );
          },
        ),
      ],
    );
  }
}
