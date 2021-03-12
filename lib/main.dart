import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './data/Welcome.dart';
import './data/homescreen.dart';
import './data/home_signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? "/WelcomePage"
          : "/HomePage",
      routes: {
        "/HomePage": (context) => HomeScreen(),
        "/HomeSign": (context) => HomeSignin(),
        "/WelcomePage": (context) => WelcomePage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
  // This widget is the root of your application.
}
