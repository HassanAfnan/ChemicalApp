import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TankDetail extends StatefulWidget {
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

  const TankDetail({Key key, this.ammonia, this.date, this.email, this.feed, this.nitrate, this.nitrite, this.ph, this.tds, this.weight,this.id}) : super(key: key);
  @override
  _TankDetailState createState() => _TankDetailState();
}

class _TankDetailState extends State<TankDetail> {

  String ph = "",tds ="",ammonia="",nitrite="",nitrate="",fcr="";

  getValues(){
    Firestore.instance.collection("Range").where("title",isEqualTo: "PH").get().then((value){
       value.docs.forEach((element) {
         if(widget.ph >= double.parse(element["value1"].toString()) && widget.ph <= double.parse(element["value2"].toString())){
            setState(() {
              ph = element["result"];
            });
         }
         else{
            setState(() {
              ph = "Condition not good";
            });
         }
       });
    }).whenComplete((){
      Firestore.instance.collection("Range").where("title",isEqualTo: "TDS").get().then((value1){
        value1.docs.forEach((element) {
          if(widget.tds >= double.parse(element["value1"].toString()) && widget.tds <= double.parse(element["value2"].toString())){
            setState(() {
              tds = element["result"];
            });
          }
          else{
            setState(() {
              tds = "Condition not good";
            });
          }
        });
      }).whenComplete((){
        Firestore.instance.collection("Range").where("title",isEqualTo: "ammonia").get().then((value2){
          value2.docs.forEach((element) {
            if(widget.ammonia >= double.parse(element["value1"].toString()) && widget.ammonia <= double.parse(element["value2"].toString())){
              setState(() {
                ammonia = element["result"];
              });
            }
            else{
              setState(() {
                ammonia = "Condition not good";
              });
            }
          });
        }).whenComplete((){
          Firestore.instance.collection("Range").where("title",isEqualTo: "FCR").get().then((value3){
            value3.docs.forEach((element) {
              if((widget.feed/widget.weight) >= double.parse(element["value1"].toString()) && (widget.feed/widget.weight) <= double.parse(element["value2"].toString())){
                setState(() {
                  fcr = element["result"];
                });
              }
              else{
                setState(() {
                  fcr = "Condition not good";
                });
              }
            });
          }).whenComplete((){
            Firestore.instance.collection("Range").where("title",isEqualTo: "nitrite").get().then((value3){
              value3.docs.forEach((element) {
                if((widget.nitrite) >= double.parse(element["value1"].toString()) && (widget.nitrite) <= double.parse(element["value2"].toString())){
                  setState(() {
                    nitrite = element["result"];
                  });
                }
                else{
                  setState(() {
                    nitrite = "Condition not good";
                  });
                }
              });
            }).whenComplete((){
              Firestore.instance.collection("Range").where("title",isEqualTo: "nitrate").get().then((value3){
                value3.docs.forEach((element) {
                  if((widget.nitrate) >= double.parse(element["value1"].toString()) && (widget.nitrate) <= double.parse(element["value2"].toString())){
                    setState(() {
                      nitrate = element["result"];
                    });
                  }
                  else{
                    setState(() {
                      nitrate = "Condition not good";
                    });
                  }
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tank Detail"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),

          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment,color:Colors.white),
                ),
                title: Text("PH"),
                subtitle: Text(ph),
              )
          ),
          SizedBox(height: 10,),

          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment,color:Colors.white),
                ),
                title: Text("TDS"),
                subtitle: Text(tds),
              )
          ),
          SizedBox(height: 10,),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment,color:Colors.white),
                ),
                title: Text("Ammonia"),
                subtitle: Text(ammonia),
              )
          ),
          SizedBox(height: 10,),

          // Card(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(20))
          //     ),
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         backgroundColor: Colors.indigo,
          //         child: Icon(Icons.assignment,color:Colors.white),
          //       ),
          //       title: Text("FCR"),
          //       subtitle: Text(fcr),
          //     )
          // ),
          // SizedBox(height: 10,),

          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment,color:Colors.white),
                ),
                title: Text("Nitrite"),
                subtitle: Text(nitrite),
              )
          ),
          SizedBox(height: 10,),

          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.assignment,color:Colors.white),
                ),
                title: Text("Nitrate"),
                subtitle: Text(nitrate),
              )
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
