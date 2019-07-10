import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// explicit ใช้ในการการประกาศตัวแปร

// method เอาคำสั่งมารวมกัน void type
// widget เป็นถุงใส่ของได้หลายชิ้น

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
        ));
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.blue[400],
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
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
    );
  }
}
