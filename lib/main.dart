import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'Signup.dart';
import 'Home.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exercise App",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage( {Key key}) : super(key:key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController inputusername = TextEditingController();
  TextEditingController inputpassword = TextEditingController();
  String username, password;

  final _formKey = GlobalKey<FormState>();

  Login(){
    setState(() {
      username = inputusername.text;
      password = inputpassword.text;
    });

    _auth.signInWithEmailAndPassword(
      email: '$username',
      password: '$password',
    ).then((user) {
      print("signed in");
      checkAuth(context);
    }).catchError((error) {
      print(error);
      _showAlert(context);
    });
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('อีเมลหรือรหัสผ่านที่คุณกรอกไม่ถูกต้อง.',
          style: TextStyle(
          fontSize: 25,
          fontFamily: "Kanit",
        ),),
        actions: [
          FlatButton(
            onPressed: () =>  Navigator.of(context).pop(),
            child: Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  Future checkAuth(BuildContext context) async {
    User user = await _auth.currentUser;
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(user: user)));
    }
  }
  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  @override
  void dispose() {
    inputusername.dispose();
    inputpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แอปพลิเคชันออกกำลังกาย',
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
                Text ('ยินดีต้อนรับ!',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Kanit",
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("https://image.freepik.com/free-vector/runners-with-face-masks-outdoors_23-2148584725.jpg"),
                      )
                  ),
                ),
                TextFormField(
                  controller: inputusername,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (isEmail(value)) {
                      return null;
                    }
                    return 'โปรดใส่อีเมลของคุณ.';
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Kanit",
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'อีเมล'
                  ),
                ),
                TextFormField(
                  controller: inputpassword,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Kanit",
                  ),
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    }
                    return 'โปรดใส่รหัสผ่านของคุณ.';
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Kanit",
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน'
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          Login();
                        }
                      },
                      child: Text('เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Kanit",
                        ),),
                    ),
                    RaisedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Signup(),
                      )),
                      child: Text('สมัครสมาชิก',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Kanit",
                        ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


