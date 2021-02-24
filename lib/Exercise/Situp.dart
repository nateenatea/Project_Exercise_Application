import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:all_sensors/all_sensors.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Achievement.dart';

class situp extends StatefulWidget {
  @override
  _situpState createState() => _situpState();
}

class _situpState extends State<situp> {

  //stopwatch
  bool startp = true;
  bool stopp = true;
  bool resetp = true;
  String stoptime = '00:00:00';
  String save = '00.00.00';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      stoptime = (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
          ":" +
          (swatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0');
    });
  }

  void start() {
    setState(() {
      stopp = false;
      startp = false;
      resetp = true;
    });
    swatch.start();
    startTimer();
  }

  void stop() {
    setState(() {
      stopp = true;
      resetp = false;
    });
    swatch.stop();
  }

  //algorithm
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  bool _proximityValues = false;
  int counter = 0;
  int time = 0;
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Counter() {
    if(startp == false){
      if(_proximityValues == true && time == 0){
        time = 1;
      }
      else if(_proximityValues == false && time == 1){
        setState(() {
          if(stopp == false){
            counter++;
            Vibration.vibrate();
          }
          time = 0;
        });
      }
    }
  }

  void reset() {
    DateTime now = DateTime.now();
    String Time = DateFormat('kk:mm:ss').format(now);
    String Date = DateFormat('dd-MM-yyyy').format(now);
    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;

    AchievementSitUp(counter,context);

    Map<String,dynamic> Data = {"Name" : 'ซิทอัพ', "Times" : stoptime , "Counter" : counter , "Time" : Time , "Date" : Date};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('exercise');
    collectionReference.add(Data);

    setState(() {
      counter = 0;
      time = 0;
      startp = true;
      resetp = true;
    });
    swatch.reset();
    save = stoptime;
    stoptime = '00:00:00';
    Navigator.pop(context);
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("เสร็จสิ้น?", style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
        content: Text('คุณต้องการที่จะหยุดออกกำลังกายแล้วใช่หรือไม่?', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
        actions: [
          FlatButton(
            onPressed: () =>  Navigator.of(context).pop(),
            child: Text('ไม่', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              reset();
            },
            child: Text('ยืนยัน', style: TextStyle(fontSize: 20, fontFamily: "Kanit"),),
          ),
        ],
      ),
    );
  }

  alert() {
    _showAlert(context);
  }

  @override
  Widget build(BuildContext context) {

    Counter();

    final List<String> imgList = [
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/153195842_470239630821006_4623901711493530751_n.jpg?_nc_cat=100&ccb=3&_nc_sid=ae9488&_nc_eui2=AeHcxLAn2lVW9mitL1DAn_qWiZcsLgiqIbyJlywuCKohvGuhZhtvqc54cMWzTDMPQPajtChZcOips4B1we76_tCH&_nc_ohc=Pd4RnyxJAzwAX-3m0p1&_nc_ht=scontent.fcnx4-1.fna&oh=ae379eef5103ce2d041c96ea1f8fcfaa&oe=6056D591',
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/151985012_179033170352351_6137093922704912209_n.jpg?_nc_cat=104&ccb=3&_nc_sid=ae9488&_nc_eui2=AeGYWXtWTDIa7V4LiALNDLKWZbzhNs5cNmZlvOE2zlw2Zmwn_sKZCmXEwFZGvI2bMRXl_bLc02T3pOxE4NoH7hVf&_nc_ohc=FNMMJherFVYAX8LYRKi&_nc_ht=scontent.fcnx4-1.fna&oh=c8169422dd624d63ffc4f87171a8bcd6&oe=605943A4',
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152931338_249860656739841_6393669857019555547_n.jpg?_nc_cat=101&ccb=3&_nc_sid=ae9488&_nc_eui2=AeGLd7xkMzUiGuReY4PyVVEZDppfimLJst0Oml-KYsmy3ZmLRVrz6uKkEA8O92e_lVhJ5YHFtqgNZBJa4R7tzmG2&_nc_ohc=f3ExGUgJuGEAX88CQRE&_nc_ht=scontent.fcnx4-1.fna&oh=29eb038fbe51f8ad2a56faf212526fd0&oe=6058F394'
    ];

    final List<Widget> imageSliders = imgList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'รูปที่ ${imgList.indexOf(item)+1}',
                      style: TextStyle(
                        fontFamily: "Kanit",
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ซิทอัพ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 90.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  autoPlay: false,
                ),
                items: imageSliders,
              )
          ),
          Text('ระยะเวลา : $stoptime', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
          Text('ซิทอัพ : $counter ครั้ง', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                RaisedButton(
                  onPressed: stopp ? start : stop,
                  child: stopp ? Text('จับเวลา', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),) : Text('หยุด', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                ),
                Text(''),
                RaisedButton(
                  onPressed: resetp ? null : alert,
                  child: Text('เสร็จสิ้น', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));

    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions
        .add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximityValues = event.getValue();
      });
    }));
  }
}
