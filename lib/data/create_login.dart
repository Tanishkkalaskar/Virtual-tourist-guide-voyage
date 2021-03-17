import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homescreen.dart';

class CreateLogin extends StatefulWidget {
  final Function cancelBackToHome;
  CreateLogin({this.cancelBackToHome});

  @override
  _CreateLoginState createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, passwdConfirm;
  final formKey = GlobalKey<FormState>();
  bool saveAttempted = false;

  void _CreateUser({String email, String pwd}) {
    _auth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: pwd.trim())
        .then((authResult) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }).catchError((err) {
      print(err.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Text(
              "CREATE YOUR LOGIN",
              style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            TextFormField(
              onChanged: (textValue) {
                setState(() {
                  email = textValue;
                });
              },
              validator: (emailValue) {
                if (emailValue.isEmpty) {
                  return 'This field is mandatory';
                }
                String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                    ")+";
                RegExp regExp = new RegExp(p);
                if (regExp.hasMatch(emailValue)) {
                  return null;
                }
                return "Please enter a valid Email";
              },
              decoration: InputDecoration(
                  hintText: "Email",
                  focusColor: Colors.black,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            TextFormField(
              onChanged: (textValue) {
                setState(() {
                  password = textValue;
                });
              },
              validator: (pwdValue) {
                if (pwdValue.isEmpty) {
                  return 'This field is mandatory';
                }
                if (pwdValue.length < 8) {
                  return 'Password must be atleast 8 characters';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  focusColor: Colors.black,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            TextFormField(
              onChanged: (textValue) {
                setState(() {
                  passwdConfirm = textValue;
                });
              },
              validator: (pwdConfValue) {
                if (pwdConfValue != password) {
                  return 'Password doesn\'t match';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  focusColor: Colors.black,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      saveAttempted = true;
                    });
                    widget.cancelBackToHome();
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _CreateUser(email: email, pwd: password);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
