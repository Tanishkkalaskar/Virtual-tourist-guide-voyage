import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voyage/data/Admin.dart';
import 'package:voyage/data/update.dart';

class userM
 {
  final user = FirebaseAuth.instance.currentUser;
  authorizeAdmin(BuildContext context) {
      FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((docs) {
        if (docs.docs[0].exists) {
          if (docs.docs[0].data()['role'] == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Update()),
            );
          } else {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Dear User"),
                  content: Text("You are not authorized to access this section "),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Okay"),
                    ),
                  ],
                ),
              );
            print('Access Denied');
          }
        }
      });
    }
 }
