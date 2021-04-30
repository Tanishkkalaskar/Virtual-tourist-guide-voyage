import 'package:flutter/material.dart';

import 'land_title_with_image.dart';
import 'package:voyage/data/products.dart';
import 'package:voyage/data/constraints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:voyage/data/Feedback.dart';

class Body extends StatelessWidget {
  final Landmark landm;
  final String groupId = "F3Yrlbjpvpzr6HOAiG8Y";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Body({Key key, this.landm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                        top: size.height * 0.11,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Expanded(
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('data')
                                  .doc(landm.title)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return new CircularProgressIndicator();
                                }
                                var document = snapshot.data;
                                return Expanded(child: SingleChildScrollView(child: new Text(document[landm.title],style: GoogleFonts.montserrat(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20.0,
                                          
                                          color: Colors.black))));
                              }),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Reviews",
                                  style: GoogleFonts.montserrat(
                                      textStyle:
                                          Theme.of(context).textTheme.headline2,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 25.0,
                                      color: Colors.black)),
                            ],
                          ),
                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection("group")
                                .doc(groupId)
                                .collection("landmarks")
                                .doc(landm.title)
                                .collection("reviews")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> querySnapshot) {
                              if (querySnapshot.hasError) {
                                return Text("Some Error");
                              }
                              if (querySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                final list = querySnapshot.data.docs;
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(list[index]["email"]),
                                      subtitle: Text(list[index]["review"]),
                                    );
                                  },
                                  itemCount: list.length,
                                );
                              }
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                  ProductTitleWithImage(landm: landm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
