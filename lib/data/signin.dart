import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './homescreen.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = await _auth.currentUser;
    String uid1 = currentUser.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({"role": "admin",
        "uid":uid1});
    assert(user.uid == currentUser.uid);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    return 'signInWithGoogle succeeded: $user';
  }

  String email, password;
  void _signIn({String em, String pw}) async {
    try {
      final UserCredential result =
          await _auth.signInWithEmailAndPassword(email: em, password: pw);
      final User user = result.user;
      String uid2 = user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({"role":"admin","uid":uid2});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    } catch (e) {
      print(e.message);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              TextField(
                onChanged: (textValue) {
                  setState(() {
                    email = textValue;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    focusColor: Colors.black,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              TextField(
                onChanged: (textValue) {
                  setState(() {
                    password = textValue;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    focusColor: Colors.black,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  _signIn(em: email, pw: password);
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text("Or"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: (){
                    signInWithGoogle();
                  },
                    child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Icon(FontAwesomeIcons.google, color: Colors.white),
                ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          color: Colors.black.withOpacity(0.2),
          child: Text("DON'T HAVE AN ACCOUNT? SIGN UP",
              style: TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
        )
      ],
    );
  }
}
