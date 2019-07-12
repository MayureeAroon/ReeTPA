import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ree_tpa/models/ree_video_model.dart';

class ShowListVideo extends StatefulWidget {
  @override
  _ShowListVideoState createState() => _ShowListVideoState();
}

class _ShowListVideoState extends State<ShowListVideo> {
// explicit

  Firestore fireStore = Firestore.instance;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ReeVideoModel> reeVideoModels = [];

// Method

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('ReeVideo');

    subscription = await collectionReference.snapshots().listen((response) {
      snapshots = response.documents;

      for (var snapshot in snapshots) {
        String nameVideo = snapshot.data['Name'];
        String detailVideo = snapshot.data['Detail'];
        String pathImage = snapshot.data['PathImage'];
        String pathVideo = snapshot.data['PathVideo'];

        ReeVideoModel reeVideoModel =
            ReeVideoModel(nameVideo, detailVideo, pathImage, pathVideo);

        setState(() {
          reeVideoModels.add(reeVideoModel);
        });

        // print('$pathImage');  สำหรับเช็คค่าแต่ละค่าเท่านั้น เมื่อเช็คว่าครบแล้ว สามารถปิดได้ ไม่จำเป็นต้องทำทั้งหมดทุกค่า ระบบจะวนไปเรื่อย ๆ
      }
    });
  }

  Widget showImage(int index) {
    // margin: EdgeInsets.all(5.0), ใส่ขอบเขตให้ขยับจากหน้าจอ
    return Container(
      margin: EdgeInsets.all(5.0),
      width: 180.0,
      height: 120.0,
      child: Image.network(
        reeVideoModels[index].pathImage,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              reeVideoModels[index].name,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.pink[900],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(reeVideoModels[index].detail),
          )
        ],
      ),
    );
  }

  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.blue[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Text('Show ListVideo'); เปลี่ยนค่าการแสดง
    return Container(
      alignment: Alignment.topLeft,
      child: ListView.builder(
        itemCount: reeVideoModels.length,
        itemBuilder: (context, int index) {
          return Container(
            // child: Text(reeVideoModels[index].name),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    showImage(index),
                    showText(index),
                  ],
                ),
                myDivider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
