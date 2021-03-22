import 'package:flutter/material.dart';
import 'body_discover.dart';

class discoverScreen extends StatelessWidget {
  const discoverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Body(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Text("voyage"),
      actions: [
        IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.image,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
