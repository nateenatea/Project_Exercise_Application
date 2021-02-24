import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool check1, check2, check3, check4, check5, check6, check7, check8, check9, check10, check11, check12, check13, check14, check15, check16;
Map data = null;
var user = FirebaseAuth.instance.currentUser;
String uid = user.uid;

fetchdata() {
  if (uid != null) {
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    userCollection.snapshots().listen((snapshot) {

      data = snapshot.docs[0].data();

    });
  }
}

void AchievementJumpingJack (int counter, context) async {
  fetchdata();
  if(counter >= 5 && data['check1'] == false) {
    check1 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check1" : check1});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักกระโดดตบมือใหม่",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 10 && data['check5'] == false) {
    check5 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check5" : check5});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nกระโดดตบอย่างคล่องแคล่ว",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 20 && data['check9'] == false) {
    check9 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check9" : check9});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักกระโดดตบระดับสูง",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 50 && data['check13'] == false) {
    check13 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check13" : check13});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nผู้เเชี่ยวชาญด้านการกระโดดตบ",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
}

void AchievementPushUp (int counter, context) async {
  fetchdata();
  if(counter >= 5 && data['check2'] == false) {
    check2 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check2" : check2});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักดันพื้นมือใหม่",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 10 && data['check6'] == false) {
    check6 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check6" : check6});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nดันพื้นอย่างคล่องแคล่ว",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 20 && data['check10'] == false) {
    check10 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check10" : check10});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักดันพื้นระดับสูง",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 40 && data['check14'] == false) {
    check14 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check14" : check14});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nผู้เชี่ยวชาญด้านการดันพื้น",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
}

void AchievementSitUp (int counter, context) async {
  fetchdata();
  if(counter >= 5 && data['check3'] == false) {
    check3 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check3" : check3});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nหัดซิทอัพ",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 10 && data['check7'] == false) {
    check7 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check7" : check7});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nซิทอัพอย่างคล่องแคล่ว",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 20 && data['check11'] == false) {
    check11 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check11" : check11});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักซิทอัพระดับสูง",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 40 && data['check15'] == false) {
    check15 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check15" : check15});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nผู้เชี่ยวชาญด้านการซิทอัพ",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
}

void AchievementRunning (int counter, context) async { // 4 8 12 16
  fetchdata();
  if(counter >= 20 && data['check4'] == false) {
    check4 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check4" : check4});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักวิ่งมือใหม่",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 50 && data['check8'] == false) {
    check8 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check8" : check8});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nวิ่งอย่างคล่องแคล่ว",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 100 && data['check12'] == false) {
    check12 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check12" : check12});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nนักวิ่งระดับสูง",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
  if(counter >= 200 && data['check16'] == false) {
    check16 = true;

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"check16" : check16});

    AchievementView(
      context,
      title: "ยินดีด้วย!",
      subTitle: "คุณได้รับเหรียญตรา\nผู้เชี่ยวชาญด้านการวิ่ง",
      textStyleTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      textStyleSubTitle: TextStyle(fontSize: 20, fontFamily: "Kanit"),
      isCircle: true,
      icon: Icon(Icons.star_border, color: Colors.white),
      color: Colors.lightBlue,
      listener: (status) {
        print(status);
      },
    )..show();
  }
}

bool show1 () {
  fetchdata();
  if(data['check1'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show2() {
  fetchdata();
  if(data['check2'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show3() {
  fetchdata();
  if(data['check3'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show4() {
   fetchdata();
  if(data['check4'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show5() {
  fetchdata();
  if(data['check5'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show6() {
  fetchdata();
  if(data['check6'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show7() {
  fetchdata();
  if(data['check7'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show8() {
  fetchdata();
  if(data['check8'] == true) {
    return true;
  } else {
    return false;
  }
}
bool show9() {
  fetchdata();
  if(data['check9'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show10() {
  fetchdata();
  if(data['check10'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show11() {
  fetchdata();
  if(data['check11'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show12() {
  fetchdata();
  if(data['check12'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show13() {
  fetchdata();
  if(data['check13'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show14() {
  fetchdata();
  if(data['check14'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show15() {
  fetchdata();
  if(data['check15'] == true) {
    return true;
  } else {
    return false;
  }
}

bool show16() {
  fetchdata();
  if(data['check16'] == true) {
    return true;
  } else {
    return false;
  }
}