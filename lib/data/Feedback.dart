import 'package:flutter/material.dart';
import 'package:voyage/data/products.dart';
import 'details/land_title_with_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyage/data/signin.dart';
import 'package:voyage/data/homescreen.dart';

class feedback extends StatelessWidget {
  final Landmark landm;
  feedback({Key key, this.landm}) : super(key: key);
  final String groupid = "F3Yrlbjpvpzr6HOAiG8Y";
  final FirebaseAuth auth = FirebaseAuth.instance;

  String inputData() {
    final User user = auth.currentUser;
    final uid = user.uid;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _userController = new TextEditingController();

  Future<String> SendFeedback(
    String groupId,
    String landmarkId,
    String email,
    String review,
  ) async {
    String retVal = "error";
    String uid = inputData();
    try {
      await _firestore
          .collection("group")
          .doc(groupId)
          .collection("landmarks")
          .doc(landmarkId)
          .collection("reviews")
          .doc(uid)
          .set({
        'email': email,
        'review': review,
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      cursorColor: Colors.black,
                      cursorWidth: 2.0,
                      decoration: InputDecoration(
                        labelText: "Enter Email-Id",
                        fillColor: Colors.white,
                        icon: Icon(Icons.supervised_user_circle),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      style:
                          TextStyle(color: Color(0xff4baea0), fontSize: 12.0),
                      controller: _userController,
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextField(
                      cursorColor: Colors.black,
                      cursorWidth: 2.0,
                      decoration: InputDecoration(
                        labelText: "Enter Message",
                        icon: Icon(Icons.message),
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      style:
                          TextStyle(color: Color(0xff4baea0), fontSize: 12.0),
                      controller: _controller,
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    color: Color(0xff4baea0),
                    child: Text(
                      "Send Feedback",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    onPressed: () {
                      SendFeedback(groupid, landm.title, _userController.text,
                          _controller.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
