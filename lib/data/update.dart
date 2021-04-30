import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Update extends StatefulWidget {
  Update({Key key}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  String landmarkName, information;

  getLandmarkName(name) {
    this.landmarkName = name;
  }

  getInfo(info) {
    this.information = info;
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("data").doc(landmarkName);
    String name = landmarkName.toString();
    Map<String, dynamic> landmarks = {name: information};
    documentReference.set(landmarks).whenComplete(() {
      print("$name created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("data").doc(landmarkName);
    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()["name"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("data").doc(landmarkName);
    String name = landmarkName.toString();
    Map<String, dynamic> landmarks = {name: information};
    documentReference.set(landmarks).whenComplete(() {
      print("$name updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("data").doc(landmarkName);

    documentReference.delete().whenComplete(() {
      print("$landmarkName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Landmark/Monument Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String name) {
                    getLandmarkName(name);
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Information",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String info) {
                    getInfo(info);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "CREATE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    createData();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "READ",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    readData();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    updateData();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
