import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_exercise_demo_v1/main.dart';
import 'Select.dart';
import 'Calendar.dart';
import 'Profile.dart';

class Home extends StatefulWidget {

  final User user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    select(),
    calendar(),
    profile(),
  ];

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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('หน้าหลัก', style: TextStyle(fontSize: 18, fontFamily: "Kanit"),),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('ประวัติการใช้งาน', style: TextStyle(fontSize: 18, fontFamily: "Kanit"),),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('ข้อมูลส่วนตัว', style: TextStyle(fontSize: 18, fontFamily: "Kanit"),),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
