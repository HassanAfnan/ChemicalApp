import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddValue extends StatefulWidget {
  final String id;
  final String tank;

  const AddValue({Key key, this.id, this.tank}) : super(key: key);
  @override
  _AddValueState createState() => _AddValueState();
}

class _AddValueState extends State<AddValue> {
  String seletedDate;
  double feed = 0,feed1 = 0,feed2 = 0;
  double ph,tds,ammonia,nitrate,nitrite;
  double weight;
  void presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value){
      if(value == null){
        return;
      }
      setState(() {
        seletedDate = DateFormat.yMMMd().format(value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Values for tank"),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                // TextField(
                //   decoration: InputDecoration(
                //       labelText: "Feed for morning"
                //   ),
                //   onChanged: (value){
                //     feed = double.parse(value);
                //   },
                // ),
                // TextField(
                //   decoration: InputDecoration(
                //       labelText: "Feed for evening"
                //   ),
                //   onChanged: (value){
                //     feed1 = double.parse(value);
                //   },
                // ),
                // TextField(
                //   decoration: InputDecoration(
                //       labelText: "Feed for night"
                //   ),
                //   onChanged: (value){
                //     feed2 = double.parse(value);
                //   },
                // ),
                // TextField(
                //   decoration: InputDecoration(
                //       labelText: "Weight gain by fishes"
                //   ),
                //   onChanged: (value){
                //     weight = double.parse(value);
                //   },
                // ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter your PH"
                  ),
                  onChanged: (value){
                    ph = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter your TDS"
                  ),
                  onChanged: (value){
                    tds = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter your Ammonia"
                  ),
                  onChanged: (value){
                    ammonia = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter your Nitrite"
                  ),
                  onChanged: (value){
                    nitrite = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter your Nitrate"
                  ),
                  onChanged: (value){
                    nitrate = double.parse(value);
                  },
                ),
                Row(
                  children: [
                    Text(seletedDate == null ? 'No Date Chosen': seletedDate),
                    Platform.isIOS ? CupertinoButton(
                      child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: presentDatePicker,
                    ) :  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: presentDatePicker,
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text("Add Value"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    addTank();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  addTank(){
    FirebaseFirestore.instance.collection("History").doc().set({
      'feed': 0,
      'weight': weight,
      'ph': ph,
      'tds': tds,
      'ammonia': ammonia,
      'nitrite': nitrite,
      'nitrate': nitrate,
      'email': FirebaseAuth.instance.currentUser.email,
      'date': seletedDate.toString(),
      'tank': widget.tank
    }).whenComplete((){
      FirebaseFirestore.instance.collection("Tank").doc(widget.id).update({
        'feed': 0,
        'weight': weight,
        'ph': ph,
        'tds': tds,
        'ammonia': ammonia,
        'nitrite': nitrite,
        'nitrate': nitrate,
        'email': FirebaseAuth.instance.currentUser.email,
        'date': seletedDate.toString(),
        'tank': widget.tank
      }).whenComplete((){
        print("Value Updated");
        Navigator.pop(context);
      });
    });
  }
}
