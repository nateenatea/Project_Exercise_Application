import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:all_sensors/all_sensors.dart';
import 'package:flutter_app_exercise_demo_v1/Achievement.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';



class pushup extends StatefulWidget {
  @override
  _pushupState createState() => _pushupState();
}

class _pushupState extends State<pushup> {

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
  double _proximityValues2;
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

    AchievementPushUp(counter,context);

    Map<String,dynamic> Data = {"Name" : 'ดันพื้น', "Times" : stoptime , "Counter" : counter , "Time" : Time , "Date" : Date};
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

    final List<String> accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
    _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    final List<String> imgList = [
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152706631_853884088801161_250904184247044784_n.jpg?_nc_cat=109&ccb=3&_nc_sid=ae9488&_nc_eui2=AeEteg20RbYhuSxUfb833Mc4HOH0LvXWiXQc4fQu9daJdFDsKfu9XpQYSJoQHHoeH2_pGKEgfy-lvU2cz6DzatSE&_nc_ohc=dWWYE1evct4AX8tMId9&_nc_ht=scontent.fcnx4-1.fna&oh=f8616cc886aa2b47d7fbbc1d048f86c0&oe=60576A72',
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152078969_432874321319815_8792179367279697635_n.jpg?_nc_cat=102&ccb=3&_nc_sid=ae9488&_nc_eui2=AeEa-3bsbgjgyT-vZWz2OxcSnSpTvYwlWImdKlO9jCVYidivFdPj4gd6LuRrycWVleCfnaV1bIRplMXM77PLImu6&_nc_ohc=-38AAd_5U-cAX-ft5MS&_nc_ht=scontent.fcnx4-1.fna&oh=2f86311c2260180586aaecb7e12a4715&oe=60595141',
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152006776_856505224916398_2392075585242886852_n.jpg?_nc_cat=111&ccb=3&_nc_sid=ae9488&_nc_eui2=AeE6NYhcKcaF0saF9zf7c85xFbvQeWTqE-QVu9B5ZOoT5HcBt71uLQzFKZv5I9KXvIppE0qTHp8ijKLtn5GuvXdZ&_nc_ohc=xl5ntmKufEIAX9Qtnne&_nc_ht=scontent.fcnx4-1.fna&oh=78f77b4bbe07f4d1ad75e122732c5d74&oe=6056844E'
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
        title: Text('ดันพื้น', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
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
          Text('ดันพื้น : $counter ครั้ง', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
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
    _streamSubscriptions
        .add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximityValues2 = event.proximity;
      });
    }));
  }

}
