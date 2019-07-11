import 'package:flutter/material.dart';
import 'package:ree_tpa/screens/my_service.dart';
import 'package:ree_tpa/screens/registe.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// explicit ใช้ในการการประกาศตัวแปร

  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;
  final scaffoldkey = GlobalKey<ScaffoldState>();

// method เอาคำสั่งมารวมกัน void type

  void mySnackBar(String messageSting) {
    SnackBar snackBar = SnackBar(
      content: Text(messageSting),
      duration: Duration(seconds: 8),
      backgroundColor: Colors.blue[600],
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldkey.currentState.showSnackBar(snackBar);
  }

// widget เป็นถุงใส่ของได้หลายชิ้น
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      moveToService();
    }
  }

  void moveToService() {
    var serviceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

  Widget showLogo() {
    return Container(
      width: 180.0,
      height: 180.0,
      child: Image.asset(
        'images/logo00.png',
      ),
    );
  }

  Widget showText() {
    return Text(
      'Ree TPA',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.blue[900],
        fontWeight: FontWeight.bold,
        fontFamily: 'MountainsofChristmas',
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(labelText: 'email : ', hintText: 'you@email.com'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Plase Fill Email';
          }
        },
        onSaved: (String value) {
          emailString = value;
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
        width: 250.0,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password :', hintText: 'More 6 Charactor'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Plase Fill Password';
            }
          },
          onSaved: (String value) {
            passwordString = value;
          },
        ));
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    print('email = $emailString,password = $passwordString');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      moveToService();
    }).catchError((response) {
      String messageString = response.message;
      print('message =$messageString');
      mySnackBar(messageString);
    });
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.blue[400],
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click Sign up');

// Create Route
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: signInButton(),
          ),
          mySizeBox(),
          Expanded(
            child: signUpButton(),
          ),
        ],
      ),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.white, Colors.blue[900]],
          radius: 2.0,
          center: Alignment.topCenter,
        )),
        padding: EdgeInsets.only(top: 60.0),
        alignment: Alignment.topCenter,
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              showLogo(),
              showText(),
              emailText(),
              passwordText(),
              showButton(),
            ],
          ),
        ),
      ),
    );
  }
}
