import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// explicit

// method

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
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
            child: Column(
              children: <Widget>[
                nameText(),
                emailText(),
                passwordText(),
              ],
            ),
          ),
        ));
  }
}
