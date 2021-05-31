import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFCR extends StatefulWidget {
  const AddFCR({Key key}) : super(key: key);

  @override
  _AddFCRState createState() => _AddFCRState();
}

class _AddFCRState extends State<AddFCR> {
  String seletedDate;
  double feed,feed1,feed2;
  double weight;
  List<String> tanks = [];
  String tankName;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getTanks();
  }

  getTanks(){
    FirebaseFirestore.instance.collection("Tank").where("email",isEqualTo: FirebaseAuth.instance.currentUser.email).get().then((value){
      value.docs.forEach((element) {
        setState(() {
          tanks.add(element["tank"]);
        });
      });
      print(tanks.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add FCR"),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        isExpanded: true,
                        hint:  Text("Select Tank"),
                        value: tankName,
                        onChanged: (String Value) {
                          setState(() {
                            tankName = Value;
                          });
                        },
                        items: tanks.map((String user) {
                          return  DropdownMenuItem<String>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  user,
                                  style:  TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Feed for morning"
                  ),
                  onChanged: (value){
                    feed = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Feed for evening"
                  ),
                  onChanged: (value){
                    feed1 = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Feed for night"
                  ),
                  onChanged: (value){
                    feed2 = double.parse(value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Weight gain by fishes"
                  ),
                  onChanged: (value){
                    weight = double.parse(value);
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
                    saveFcr();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  saveFcr(){
    FirebaseFirestore.instance.collection("FCR").doc().set({
      'tank': tankName,
      'feed': feed + feed1 + feed2,
      'weight': weight,
      'date': seletedDate,
      'email': FirebaseAuth.instance.currentUser.email
    }).whenComplete((){
     Navigator.pop(context);
    });
  }
}
