import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// explicit

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// Method listview ใส่ข้อมูลเกินจอได้

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
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: myDawerMenu(),
    );
  }
}
