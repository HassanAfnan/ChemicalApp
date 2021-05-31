import 'package:chemical/admin.dart';
import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/login.dart';
import 'package:chemical/models/range_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RangeScreen extends StatefulWidget {
  @override
  _RangeScreenState createState() => _RangeScreenState();
}

class _RangeScreenState extends State<RangeScreen> {
  List<RangeModel> ranges = [];

  getRanges(){
    FirebaseFirestore.instance.collection("Range").get().then((value){
      value.docs.forEach((element) {
        setState(() {
          ranges.add(RangeModel(
              element.id,
              element["title"],
              element["value1"].toString(),
              element["value2"].toString(),
              element["result"]
          ));
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRanges();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Range"),
      ),
      body: ListView.builder(
          itemCount: ranges.length,
          itemBuilder: (context,index){
           return WidgetAnimator(
               ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.indigo,
                   child: Icon(Icons.assignment,color: Colors.white,),
                 ),
                 title: Text(ranges[index].title+" Value1: "+ranges[index].value1+" Value2: "+ranges[index].value2),
                 subtitle: Text(ranges[index].result),
                 trailing: IconButton(
                   onPressed: (){
                     FirebaseFirestore.instance.collection("Range").doc(ranges[index].id).delete().whenComplete((){
                       print("deleted");
                       setState(() {
                         ranges.removeAt(index);
                       });
                     });
                   },
                   icon: Icon(Icons.delete,color: Colors.red,),
                 ),
               )
           );
      }),
    );
  }
}
