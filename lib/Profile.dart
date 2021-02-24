import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise_demo_v1/Notifications.dart';
import 'Achievement.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {

  Map data = null;

  fetchdata() {
    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;
    if (uid != null) {
      CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('Account');
      userCollection.snapshots().listen((snapshot) {

        setState(() {
          data = snapshot.docs[0].data();
        });

      });
    }
  }

  test() {
    if(show1() == true) {
      print('YES');
    } else {
      print('No!');
    }
  }

  @override
  void initState() {
    // test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    fetchdata();
    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('โปรไฟล์', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('Account').snapshots(),
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
            return ListView(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text('ชื่อ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                      subtitle: Text(data['Name'].toString(), style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                    ),
                    ListTile(
                      title: Text('อายุ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                      subtitle: Text(data['Age'].toString() + ' ปี', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                    ),
                    ListTile(
                      title: Text('ส่วนสูง', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                      subtitle: Text(data['Height'].toString() + 'เซนติเมตร', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                    ),
                    ListTile(
                      title: Text('น้ำหนัก', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                      subtitle: Text(data['Weight'].toString() + ' กิโลกรัม', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                    ),
                    ListTile(
                      title: Text('รางวัลความสำเร็จ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Notifications(payload: null),
                      )),
                    ),
                  ]
              ).toList(),
            );
          }
        },
      ),
    );
  }
}
