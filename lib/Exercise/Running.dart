import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Achievement.dart';

class running extends StatefulWidget {
  @override
  _runningState createState() => _runningState();
}

class _runningState extends State<running> {

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
  int _counter = 0;
  bool handdown = true;
  bool handup = false;
  int time = 0;

  double test;

  double max = 0;
  double min = 0;

  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  void CounterNumber() {
    if(startp == false) {
      if(_accelerometerValues[0] >= 5){
        if(time == 0){
          if(handdown == true || handup == false) {
            handdown = false;
            handup = true;
          }
          else if(handdown == false || handup == true) {
            handdown = true;
            handup = false;
            setState(() {
              if(stopp == false){
                _counter++;
              }
              // Max();
            });
          }
          time = 1;
        }
      }
      if(_accelerometerValues[0] < 5){
        time = 0;
      }
    }
  }

  void reset() {
    DateTime now = DateTime.now();
    String Time = DateFormat('kk:mm:ss').format(now);
    String Date = DateFormat('dd-MM-yyyy').format(now);
    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;

    AchievementRunning(_counter,context);

    Map<String,dynamic> Data = {"Name" : 'วิ่ง', "Times" : stoptime , "Counter" : _counter , "Time" : Time , "Date" : Date};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('exercise');
    collectionReference.add(Data);

    setState(() {
      _counter = 0;
      handdown = true;
      handup = false;
      max = 0;
      min = 0;
      startp = true;
      resetp = true;
    });
    swatch.reset();
    save = stoptime;
    stoptime = '00:00:00';
    Navigator.pop(context);
  }

  void Max() {
    if(max < test){
      max = double.parse(test.toStringAsFixed(2));
    }
    if(max != 0) {
      if(min == 0){
        min = max;
      }
      if(min > test) {
        min = double.parse(test.toStringAsFixed(2));
      }
    }
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

    CounterNumber();
    Max();

    final List<String> accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();

    final List<String> imgList = [
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/151971583_756681441638671_8719002385424634933_n.jpg?_nc_cat=100&ccb=3&_nc_sid=ae9488&_nc_eui2=AeHhGzWbAqCodMda5k1lqVwoakQClX7Nft5qRAKVfs1-3vmgjk-JPmYwqfWZtdE5bmxMAmfny1Q_8NlLkrcnWzrh&_nc_ohc=Y-mY-U7uTaMAX-mIC0k&_nc_ht=scontent.fcnx4-1.fna&oh=93ae5ad272de1319ab8bd4b6678c5f2a&oe=605807E3',
      'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152018693_3696327993794865_959609859983641996_n.jpg?_nc_cat=102&ccb=3&_nc_sid=ae9488&_nc_eui2=AeGaPqzVum6v7j3px7vMAjRW0DxSLN8ZORzQPFIs3xk5HPaNDMdx85fp-5hpvK8tV_2qfSgdBfq8C9xWBiLxtnB1&_nc_ohc=oQpi1Pcz0ggAX8OKfiT&_nc_oc=AQmTddLD2z0E3evR0qKday-gxKftJkVYmhEO1hyvZTuu-4btVISJkUmEPpI3rg62bIE&_nc_ht=scontent.fcnx4-1.fna&oh=5f253015f84317a1713202f04c2d7f67&oe=605926A0'
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
        title: Text('วิ่ง', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
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
          Text('ระยะทาง : $_counter ก้าว', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
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

    accelerometerEvents.listen((AccelerometerEvent event) {
      test = event.y;
    });

    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.y];
      });
    }));
  }
}
