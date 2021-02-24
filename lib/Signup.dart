import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:validators/validators.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String email, password, confirm, name, age, height, weight;

  final _formKey = GlobalKey<FormState>();
  String check;

  signup() async {
    email = emailController.text.trim();
    password = passwordController.text.trim();
    confirm = confirmController.text.trim();
    _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Sign up user succesful.');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      addData();
    }).catchError((error) {
      print(error.message);
      _showAlert(context);
    });
  }

  addData() {
    var user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;
    name = nameController.text;
    age = ageController.text;
    height = heightController.text;
    weight = weightController.text;

    Map<String,dynamic> Data = {'Name' : '$name', 'Age' : '$age', 'Height' : '$height', 'Weight' : '$weight' };
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('Account');
    userCollection.add(Data);

    Map<String,dynamic> DataAchievement = {
      "check1" : false, "check2" : false,
      "check3" : false, "check4" : false,
      "check5" : false, "check6" : false,
      "check7" : false, "check8" : false,
      "check9" : false, "check10" : false,
      "check11" : false, "check12" : false,
      "check13" : false, "check14" : false,
      "check15" : false, "check16" : false,
    };
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('achievement');
    collectionReference.add(DataAchievement);
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("ERROR"),
          content: Text('The email address is already in use by another account.'),
          actions: [
            FlatButton(
              onPressed: () =>  Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก',
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Kanit",
          ),),
      ),
      body: ListView(
        padding: EdgeInsets.all(50),
        children: [
          Form (
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (isEmail(value)) {
                      return null;
                    }
                    return 'โปรดใส่อีเมล.';
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'อีเมล',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (value.length >= 6) {
                      setState(() {
                        check = value;
                      });
                      return null;
                    }
                    return 'รหัสผ่านต้องมีความยาวมากกว่า 6 ตัวอักษร.';
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'รหัสผ่าน',
                  ),
                ),
                TextFormField(
                  controller: confirmController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (value == check) {
                      return null;
                    }
                    return 'รหัสผ่านไม่ตรงกัน';
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'รหัสผ่านอีกครั้ง',
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (value.length >= 3) {
                      return null;
                    }
                    return 'ชื่อต้องมีความยาวมากกว่า 3 ตัวอักษร.';
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    labelText: 'ชื่อ',
                  ),
                ),
                TextFormField(
                  controller: ageController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (isNumeric(value)) {
                      return null;
                    }
                    return 'อายุต้องเป็นตัวเลขเท่านั้น.';
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'อายุ',
                  ),
                ),
                TextFormField(
                  controller: heightController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (isNumeric(value)) {
                      return null;
                    }
                    return 'ความสูงต้องเป็นตัวเลขเท่านั้น.';
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    labelText: 'ความสูง',
                  ),
                ),
                TextFormField(
                  controller: weightController,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (isNumeric(value)) {
                      return null;
                    }
                    return 'น้ำหนักต้องเป็นตัวเลขเท่านั้น.';
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: "Kanit",
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'น้ำหนัก',
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      signup();
                    }
                  },
                  child: Text('สมัครสมาชิก',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Kanit",
                    ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
