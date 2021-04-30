import 'dart:io';
import 'package:flutter/material.dart';
import 'details/details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voyage/data/map.dart';
import 'discover_screen.dart';
import 'Welcome.dart';
import 'createDrawerHeader.dart';
import 'createDrawerBodyItem.dart';
import 'admin.dart';
import 'package:voyage/data/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/data/userManagement.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return WelcomePage();
    }));
  }

  void gotodetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                landm: landmark[int.parse(_outputs[0]["label"])])));
  }

  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("voyage"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () {
                pickImageCamera();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              onPressed: () {
                pickImage();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              createDrawerHeader(),
              createDrawerBodyItem(
                  icon: Icons.home,
                  text: 'Home Page',
                  onTap: () => Navigator.pop(context)),
              createDrawerBodyItem(
                  icon: Icons.map,
                  text: 'map',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Map()),
                      )),
              createDrawerBodyItem(
                  icon: Icons.person, text: 'Admin Page', onTap: () => userM().authorizeAdmin(context)),
              Divider(),
              createDrawerBodyItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () => signOut(context)),
              ListTile(
                title: Text('App version 1.0.0'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/taj.jpg"), fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Discover India',
                  style:
                      GoogleFonts.pacifico(fontSize: 50.0, color: Colors.white),
                ),
              ),
            ),
            _outputs != null ? DetailsScreen(
                landm: landmark[int.parse(_outputs[0]["label"])]) : Container(),
          ],
        ));
  }

  pickImageCamera() async {
    //this function to grab the image from camera
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
