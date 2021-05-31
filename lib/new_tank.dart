import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTanks extends StatefulWidget {
  @override
  _NewTanksState createState() => _NewTanksState();
}

class _NewTanksState extends State<NewTanks> {

  String seletedDate;
  double feed,feed1,feed2;
  double ph,tds,ammonia,nitrate,nitrite;
  String name;
  double weight;
  List<String> emails = [];
  String value = "Choose Email";
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

  getEmails(){
    emails.add("Choose Email");
    FirebaseFirestore.instance.collection("Users").get().then((value){
       value.docs.forEach((element) {
         setState(() {
           emails.add(element.id);
         });
       });
       print(emails.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tanks"),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // we can use cupertino text field
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter tank name"
                  ),
                  onChanged: (value){
                   name = value;
                  },
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint:  Text("Select Email"),
                      value: value,
                      onChanged: (String Value) {
                        setState(() {
                          value = Value;
                        });
                      },
                      items: emails.map((String user) {
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
                  child: Text("Add Tank"),
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
    FirebaseFirestore.instance.collection("Tank").doc().set({
      'name': name,
      'feed': 0 + 0 + 0,
      'weight': 0,
      'ph': 0,
      'tds': 0,
      'ammonia': 0,
      'nitrite': 0,
      'nitrate': 0,
      'email':  value,
      'date': seletedDate.toString()
    }).whenComplete((){
      print("Added Tank");
      Navigator.pop(context);
    });
  }
}
