import 'package:chemical/add_value.dart';
import 'package:chemical/history.dart';
import 'package:chemical/models/tanks_model.dart';
import 'package:chemical/tank_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TankDetailOption extends StatefulWidget {
  final String tank;
  final String id;
  final double ammonia;
  final String date;
  final String email;
  final double feed;
  final double nitrate;
  final double nitrite;
  final double ph;
  final double tds;
  final double weight;
  final bool isAdmin;

  const TankDetailOption({Key key, this.ammonia, this.date, this.email, this.feed, this.nitrate, this.nitrite, this.ph, this.tds, this.weight, this.id, this.tank, this.isAdmin}) : super(key: key);
  @override
  _TankDetailOptionState createState() => _TankDetailOptionState();
}

class _TankDetailOptionState extends State<TankDetailOption> {
  List<TankModel> tanks = [];

  getTanks(){
    Firestore.instance.collection("Tank").where("email",isEqualTo: widget.email).get().then((value){
      value.docs.forEach((element) {
        print(element.toString());
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tank detail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isAdmin ? SizedBox():Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.indigo,
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddValue(
                        id: widget.id,
                        tank: widget.tank
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80,bottom: 80),
                      child: Text("Add Value",style: TextStyle(color: Colors.white,),
                      ),
                    ),),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.indigo,
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => History(
                          email: widget.email,
                          tank: widget.tank,
                          isAdmin: widget.isAdmin
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80,bottom: 80),
                      child: Text("Tank History",style: TextStyle(color: Colors.white,),
                      ),
                    ),),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    color: Colors.indigo,
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TankDetail(
                        ammonia: widget.ammonia,
                        date: widget.date,
                        email: widget.email,
                        feed: widget.feed,
                        nitrate: widget.nitrate,
                        nitrite: widget.nitrite,
                        ph: widget.ph,
                        tds: widget.tds,
                        weight: widget.weight,
                        id: widget.id
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80,bottom: 80),
                      child: Text("Tank Detail",style: TextStyle(color: Colors.white,),
                      ),
                    ),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
