import 'package:chemical/all_tanks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {

  List<String> emails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmails();
  }

  getEmails(){
    FirebaseFirestore.instance.collection("Users").get().then((value){
      value.docs.forEach((element) {
         print(element.id);
         setState(() {
           emails.add(element.id);
         });
      });
      print(emails.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Users"),
      ),
      body: ListView.builder(
          itemCount: emails.length,
          itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => AllTanks(
                   isAdmin: true,
                   email: emails[index],
               )));
             },
             child: Card(
               elevation: 5,
               child: Padding(
                 padding: const EdgeInsets.all(28.0),
                 child: Text(emails[index]),
               ),
             ),
           );
      })
    );
  }
}
