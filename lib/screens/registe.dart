import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ree_tpa/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// explicit
// globlekey formstate เก็บค่า format ที่ทำไว้
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// method

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString,Email = $emailString,Password =$passwordString');
          registerFirebase();
        }
      },
    );
  }

  Future<void> registerFirebase() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      print('Error = ${response.toString()}');

      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      response.updateProfile(userUpdateInfo);

      // Move to Service
      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());

          Navigator.of(context).pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route)=>false);
    });
  }

  void myAlert(String titleString, String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleString,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(messageString),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.blue[700],
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'ชื่อ-นามสกุล',
        helperStyle: TextStyle(
            color: Colors.blue[200],
            fontSize: 14.0,
            fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.face,
          size: 48.0,
          color: Colors.blue[700],
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email :',
        labelStyle: TextStyle(
          color: Colors.green[700],
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'email Format',
        helperStyle: TextStyle(
            color: Colors.green[200],
            fontSize: 14.0,
            fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.email,
          size: 48.0,
          color: Colors.green[700],
        ),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.'))))
          return 'Email Format False';
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'password :',
        labelStyle: TextStyle(
          color: Colors.orange[700],
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'more 6 Charactor',
        helperStyle: TextStyle(
            color: Colors.orange[200],
            fontSize: 14.0,
            fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.lock,
          size: 48.0,
          color: Colors.orange[700],
        ),
      ),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Password False';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          actions: <Widget>[uploadButton()],
          backgroundColor: Colors.blue[400],
          title: Text('Register'),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 40.0),
          alignment: Alignment.topCenter,
          child: Container(
            width: 250.0,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  nameText(),
                  emailText(),
                  passwordText(),
                ],
              ),
            ),
          ),
        ));
  }
}
