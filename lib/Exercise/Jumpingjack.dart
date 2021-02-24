import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Achievement.dart';

class jumpingjack extends StatefulWidget {

  @override
  _jumpingjackState createState() => _jumpingjackState();
}

class _jumpingjackState extends State<jumpingjack> {

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
      if(_accelerometerValues[0] >= 10){
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
                Vibration.vibrate();
              }
              // Max();
            });
          }
          time = 1;
        }
      }
      if(_accelerometerValues[0] < 10){
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

    AchievementJumpingJack(_counter,context);

    Map<String,dynamic> Data = {"Name" : 'กระโดดตบ', "Times" : stoptime , "Counter" : _counter , "Time" : Time , "Date" : Date};
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
    'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/152329947_785248702079440_6801300444299608481_n.jpg?_nc_cat=107&ccb=3&_nc_sid=ae9488&_nc_eui2=AeG4SsrGvTYfAJdhIzsj21lBkcw2IAfS022RzDYgB9LTbXc76tf0ittX3rkrP_HnpB5SrCipCp-WFg5h35vcQEHZ&_nc_ohc=6bMYvhGpX60AX-yMTeS&_nc_ht=scontent.fcnx4-1.fna&oh=1ee447d50524a74e4fb61cc74fbd2d62&oe=6058875E',
     'https://scontent.fcnx4-1.fna.fbcdn.net/v/t1.15752-9/151985018_707237159945365_2391838602568655538_n.jpg?_nc_cat=107&ccb=3&_nc_sid=ae9488&_nc_eui2=AeH7O52GQJSUT-wS7Fumlmk_I1M9mAnIfcIjUz2YCch9wqWJCIkHOwqq1l2itTqges0oG0_unbETH-brjFV5srMn&_nc_ohc=oaSczhnJD30AX9Atm5v&_nc_ht=scontent.fcnx4-1.fna&oh=e2627e92d8995f8ec134e781d19cf469&oe=6057D507'
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

   void _showGuide(BuildContext context) {
     showDialog(
       context: context,
       builder: (context) => AlertDialog(
         title: Text("How it work ?"),
         content: Container(
             child: CarouselSlider(
               options: CarouselOptions(
                 aspectRatio: 2.0,
                 enlargeCenterPage: true,
                 enableInfiniteScroll: false,
                 initialPage: 2,
                 autoPlay: false,
               ),
               items: imageSliders,
             )
         ),
         actions: [
           FlatButton(
             onPressed: () =>  Navigator.of(context).pop(),
             child: Text('Okay'),
           ),
         ],
       ),
     );
   }

    return Scaffold(
      appBar: AppBar(
        title: Text('กระโดดตบ', style: TextStyle(fontSize: 25, fontFamily: "Kanit"),),
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
          Text('กระโดดตบ : $_counter ครั้ง', style: TextStyle(fontSize: 30, fontFamily: "Kanit"),),
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
