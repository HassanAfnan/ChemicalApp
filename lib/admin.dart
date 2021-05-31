import 'package:chemical/login.dart';
import 'package:chemical/ranges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<String> range = [
    "PH",
    "TDS",
    "FCR",
    "nitrate",
    "ammonia",
    "nitrite"
  ];

  TextEditingController title = new TextEditingController();
  TextEditingController value1 = new TextEditingController();
  TextEditingController value2 = new TextEditingController();
  TextEditingController result = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = "PH";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin"),
        actions: [
          // IconButton(icon:Icon(Icons.exit_to_app) , onPressed:(){
          //   showDialog(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //       title: Text("AS SAMMAK FARM"),
          //       content: Text("Do you want to logout?"),
          //       actions: [
          //         FlatButton(
          //           child: Text("Yes"),
          //           onPressed:  () async {
          //             SharedPreferences prefs = await SharedPreferences.getInstance();
          //             prefs.remove('email');
          //             prefs.remove('pic');
          //             prefs.remove('name');
          //             _signOut(context);
          //           },
          //         ),
          //         FlatButton(
          //           child: Text("No"),
          //           onPressed:  () {
          //             setState(() {
          //               Navigator.pop(context);
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //   );
          // })
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20,),
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
                        hint:  Text("Select Category"),
                        value: title.text,
                        onChanged: (String Value) {
                          setState(() {
                            title.text = Value;
                          });
                        },
                        items: range.map((String user) {
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
                // we can use cupertino text field
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter first value"
                  ),
                  controller: value1,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter second value"
                  ),
                  controller: value2,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Enter Result"
                  ),
                  controller: result,
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("Add Range"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    addValue();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => RangeScreen()));
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.list,color: Colors.white,),
      ),
    );
  }
  addValue(){
    FirebaseFirestore.instance.collection("Range").doc().set({
      'title': title.text,
      'value1': double.parse(value1.text),
      'value2': double.parse(value2.text),
      'result': result.text
    }).whenComplete((){
       value1.text = "";
       value2.text = "";
       result.text = "";
    });
  }
  Future<void> _signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pop();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }
}
