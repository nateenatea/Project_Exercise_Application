import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class calendar extends StatefulWidget {
  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {

  Map data;
  int size;
  List documents;
  var test;

  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;

    Query collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('exercise').orderBy('Date', descending: true).orderBy('Time', descending: true);
    collectionReference.snapshots().listen((snapshot) {

      setState(() {
        documents = snapshot.docs;
        size = snapshot.size;
      });
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ประวัติการใช้งาน', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('exercise').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading . . . "),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    child: Container(
                      child: InkWell(
                        // onTap: () {},
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(documents[index]['Name'].toString(), style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
                              subtitle: Text('เวลาที่ใช้ : ' + documents[index]['Times'].toString()
                                  + '\nจำนวนครั้ง: ' + documents[index]['Counter'].toString()
                                  + '\nเวลา: ' + documents[index]['Time'].toString()
                                  + '\nวันที่: ' + documents[index]['Date'].toString()
                                , style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}