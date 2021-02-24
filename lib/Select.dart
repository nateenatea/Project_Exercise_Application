import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Exercise/Running.dart';
import 'Exercise/Situp.dart';
import 'Exercise/Jumpingjack.dart';
import 'Exercise/Pushup.dart';
import 'main.dart';

class select extends StatefulWidget {
  @override
  _selectState createState() => _selectState();
}

class _selectState extends State<select> {

  final notifications = FlutterLocalNotificationsPlugin();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future checkAuth(BuildContext context) async {
    User user = await _auth.currentUser;
    if (user == null) {
      FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          ModalRoute.withName('/'));
    }
  }

  @override
  void initState() {
    checkAuth(context);
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    notifications.cancelAll();
  }

  signout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        ModalRoute.withName('/'));
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ออกจากระบบ", style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
        content: Text('คุณแน่ใจว่าต้องการที่จะ\nออกจากระบบ ?', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
        actions: [
          FlatButton(
            onPressed: () =>  Navigator.of(context).pop(),
            child: Text('ยกเลิก', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
          ),
          FlatButton(
            onPressed: signout,
            child: Text('ออกจากระบบ', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("เลือกท่าออกกำลังกาย", style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
        actions: <Widget>[
          Padding (
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => _showAlert(context),
              child: Icon(
                Icons.exit_to_app,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('ออกกำลังกาย',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Kanit",
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network('https://s8.gifyu.com/images/ezgif-5-371cbdbf88b6.gif'),
                          ),
                          title: Text('กระโดดตบ', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => jumpingjack(),
                          )),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network('https://s8.gifyu.com/images/ezgif-5-98748826e0b9.gif'),
                          ),
                          title: Text('ดันพื้น', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => pushup(),
                          )),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network('https://s8.gifyu.com/images/ezgif-5-3ad86707daf897650f34eae82aa6.gif'),
                          ),
                          title: Text('ซิทอัพ', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => situp(),
                          )),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 150),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network('https://s8.gifyu.com/images/ezgif-5-3c501b252cd6.gif'),
                          ),
                          title: Text('วิ่ง', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => running(),
                          )),
                        ),
                      ]
                  ).toList(),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Text('      เข้าสู่ระบบครั้งล่าสุด\n' + FirebaseAuth.instance.currentUser.metadata.lastSignInTime.toString(), style: TextStyle(fontSize: 15, fontFamily: "Kanit", color: Colors.grey),),
          ),
        ],
      ),
    );
  }
}


