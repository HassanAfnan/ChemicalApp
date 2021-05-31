import 'package:chemical/animations/bottomAnimation.dart';
import 'package:chemical/models/tanks_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final String tank;
  final bool isAdmin;
  final String email;

  const History({Key key, this.tank, this.isAdmin, this.email}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TankModel> tanks = [];
  List<TankModel> tanks1 = [];
  String email = "";
  getTanks(){
    Firestore.instance.collection("History").where("tank",isEqualTo: widget.tank).get().then((value){
      value.docs.forEach((element) {
        setState(() {
          tanks.add(TankModel(
              element.id,
              double.parse(element["ammonia"].toString()),
              element["date"].toString(),
              element["email"],
              double.parse(element["feed"].toString()),
              double.parse(element["nitrate"].toString()),
              double.parse(element["nitrite"].toString()),
              double.parse(element["ph"].toString()),
              double.parse(element["tds"].toString()),
              double.parse(element["weight"].toString())));
        });
      });
    }).whenComplete((){
      getTankEmail();

    });
  }

  getTankEmail(){
    Firestore.instance.collection("Tank").where("tank",isEqualTo: widget.tank).get().then((value){
       value.docs.forEach((element) {
         setState(() {
           email = element["email"];
         });
       });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.tank.toString());
    getTanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text("Tank History"),
      ),
      body: tanks.length <= 0 ? Center(child: CircularProgressIndicator()) : Container(
        child: WidgetAnimator(
          Column(
            children: [
              SizedBox(height: 20,),
              Text(widget.isAdmin? widget.email:FirebaseAuth.instance.currentUser.email,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Card(
                child: Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children:[
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("Date",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("NH3",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("Nitrate",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("Nitrite",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("Tds",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Text("Ph",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.indigo),),
                      ),
                    ])
                  ],
                ),
              ),
              Card(
                child: Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: tanks.map((e){
                    return TableRow(children :[
                      Text(e.date.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      Text(e.ammonia.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text(e.nitrate.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text(e.nitrite.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text(e.tds.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text(e.ph.toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
