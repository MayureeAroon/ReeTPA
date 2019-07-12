import 'dart:core';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ree_tpa/screens/show_list_video.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// explicit

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nameString = '';

// Method listview ใส่ข้อมูลเกินจอได้

  Widget showTitleAppBar() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text('MyService'),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Login by $nameString',
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    findName();
  }

  Future<void> findName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameString = firebaseUser.displayName;
    });
    print('name = $nameString');
  }

  Future<void> signOutandExit() async {
    await firebaseAuth.signOut().then((reponse) {
      exit(0);
    });
  }

  Widget showAppName() {
    return Text(
      'Ree TPA',
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showLogo() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Image.asset('images/logo00.png'),
    );
  }

  Widget myDawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[250]),
            child: Container(
              child: Column(
                children: <Widget>[
                  showLogo(),
                  showAppName(),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.android,
              size: 36.0,
            ),
            title: Text(
              'QR code',
              style: TextStyle(fontSize: 18.0),
            ),onTap: (){
              print('Click QR code');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 36.0,
            ),
            title: Text(
              'Sign Out & Exit',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              signOutandExit();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: showTitleAppBar(),
      ),
      body: ShowListVideo(),
      drawer: myDawerMenu(),
    );
  }
}
