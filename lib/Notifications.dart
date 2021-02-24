import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Achievement.dart';

class Notifications extends StatefulWidget {
  final String payload;

  const Notifications({
    @required this.payload,
    Key key,
  }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List documents;
  int size;

  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;

    Query collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('exercise').orderBy('Date', descending: true).orderBy('Time', descending: true);
    collectionReference.snapshots().listen((snapshot) {

      setState(() {
        documents = snapshot.docs;
        size = snapshot.size;
        // data = snapshot.docs[0].data();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('รางวัลความสำเร็จ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: ColorFiltered(
                colorFilter: show1() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักกระโดดตบมือใหม่', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('กระโดดตบครบ 5 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show2() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักดันพื้นมือใหม่', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ดันพื้นครบ 5 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show3() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักซิทอัพมือใหม่', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ซิทอัพครบ 5 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show4() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักวิ่งมือใหม่', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('วิ่งครบ 20 ก้าว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show5() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('กระโดดตบอย่างคล่องแคล่ว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('กระโดดตบครบ 10 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show6() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ดันพื้นอย่างคล่องแคล่ว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ดันพื้นครบ 10 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show7() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ซิทอัพอย่างคล่องแคล่ว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ซิทอัพครบ 10 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show8() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('วิ่งอย่างคล่องแคล่ว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('วิ่งครบ 50 ก้าว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show9() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักกระโดดตบระดับสูง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('กระโดดตบครบ 20 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show10() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักดันพื้นระดับสูง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ดันพื้นครบ 20 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show11() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักซิทอัพระดับสูง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ซิทอัพครบ 20 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show12() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('นักวิ่งระดับสูง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('วิ่งครบ 100 ก้าว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show13() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ผู้เชี่ยวชาญด้านการกระโดดตบ', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('กระโดดตบครบ 50 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show14() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ผู้เชี่ยวชาญด้านการดันพื้น', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ดันพื้นครบ 40 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show15() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ผู้เชี่ยวชาญด้านการซิทอัพ', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('ซิทอัพครบ 40 ครั้ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
            ListTile(
              leading: ColorFiltered(
                colorFilter: show16() == false ? ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) : ColorFilter.matrix(<double>[
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.icons8.com/fluent/2x/prize.png'),
                  backgroundColor: Colors.cyan,
                ),
              ),
              title: Text('ผู้เชี่ยวชาญด้านการวิ่ง', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
              subtitle: Text('วิ่งครบ 200 ก้าว', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
            ),
          ]
        ).toList(),
      ),
      );
  }
}
